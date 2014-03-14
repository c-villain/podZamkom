//
//  SyncVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 29.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "SyncVC.h"


@interface SyncVC ()

@end

@implementation SyncVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad:[Translator languageSelectedStringForKey:@"SYNCHRONIZATION"]];
	// Do any additional setup after loading the view.
    self.lblLastBackup.text = @"";
    if (![[Settings getLastDateSync] isEqual:@""])
        self.lblLastBackup.text = [[Translator languageSelectedStringForKey:@"Last backup: "]  stringByAppendingString:[Settings getLastDateSync]];
    
    self.lblDropboxSync.text = [Translator languageSelectedStringForKey:@"Sync using Dropbox"];
    [self.createBackupBtn setTitle:[Translator languageSelectedStringForKey:@"CREATE BACKUP"] forState:UIControlStateNormal];
    [self.restoreBackupBtn setTitle:[Translator languageSelectedStringForKey:@"RECOVER DATA"] forState:UIControlStateNormal];
    objManager = [DropboxManager dropBoxManager];
    objManager.apiCallDelegate =self;
    [objManager initDropbox];
    
    self.dropboxSync.on = [self CheckIfDropBoxAccountIsLinked];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    //скрываем кнопки создать копию и восстановить данные, если не было линковки с аккаунтом дропбокса:
    if (![self.dropboxSync isOn])
    {
        self.createBackupBtn.alpha = 0.0;
        self.restoreBackupBtn.alpha = 0.0;
        self.lblLastBackup.alpha = 0.0;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.dropboxSyncDelegate = self;
}

- (void)setButtonsVisibility:(BOOL)visible
{
    CGFloat alpha = 0.0;
    if (visible)
        alpha = 1.0;
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.createBackupBtn.alpha = alpha;
                         self.restoreBackupBtn.alpha = alpha;
                         self.lblLastBackup.alpha = alpha;
                     } 
                     completion:^(BOOL finished){
                     }];
}

-(BOOL)CheckIfDropBoxAccountIsLinked
{
    return [objManager isLoggedIn];
}

- (void)linkingAccountFinished
{
    if ([self CheckIfDropBoxAccountIsLinked])
    {
        [self setButtonsVisibility:YES];
    }
    else
    {
        [self setButtonsVisibility:NO];
        self.dropboxSync.on = NO;
    }

}

- (IBAction)syncWithDropBox:(id)sender
{
    if ([self.dropboxSync isOn])
    {
        if (![self CheckIfDropBoxAccountIsLinked])
        {
            [objManager checkForLink];
            self.dropboxSync.on = NO;
        }
        else
            [self setButtonsVisibility:YES];
    }
    else
    {
        if (objManager)
            [objManager logoutFromDropbox];
        [self setButtonsVisibility:NO];
        self.dropboxSync.on = NO;
    }
    
}

- (void)initProgressView: (Command) command
{
    CGRect bounds = [[ UIScreen mainScreen ] bounds];
    UIView * progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, bounds.size.height*5/6, bounds.size.width, 51)];
    
    SEL sel = nil;
    NSString *currentCommand = @"";
    switch (command)
    {
        case DOWNLOAD:
            sel = @selector(stopRestore);
            currentCommand = [Translator languageSelectedStringForKey:@"Downloading"];
            break;
        case UPLOAD:
            sel = @selector(stopSync);
            currentCommand = [Translator languageSelectedStringForKey:@"Uploading"];
            break;
    }
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:48.0f/255.0f blue:71.0f/255.0f alpha:1.0f];
    [btn setTitle: [Translator languageSelectedStringForKey:@"Stop"] forState: UIControlStateNormal];
    
    [progressView addSubview:btn];
    
    CGRect size = CGRectMake(0, 0 , 150, 150);
    HUD = [[[M13ProgressHUD alloc] initWithFrame:size] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    HUD.progressViewSize = CGSizeMake(60.0, 60.0);
    
    [progressView addSubview:HUD];
    
    [progressView bringSubviewToFront:btn];
    modal = [[RNBlurModalView alloc] initWithView:progressView];
    
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal show];
    [HUD show:YES];
    HUD.status = currentCommand;
}

- (IBAction)createBackup:(id)sender
{
    [self initProgressView:UPLOAD];
    
    //создаем файл бэкапа базы данных и справочной информации для последующей синхронизации:
    if ([Sync CreateBackup])
    {
        [self setFailed: @"Не удалось\nсоздать backup"];
        return;
    }
    objManager.currentPostType = DropBoxUploadFile;
    
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    NSString *dbDir = [dbPath objectAtIndex:0];
    dbDir = [dbDir stringByAppendingPathComponent:@"Backup"];
    objManager.strFilePath = dbDir;
    objManager.strDestDirectory = @"/Backup";
    
    [objManager uploadFolder];
}

- (IBAction)restoreBackup:(id)sender
{
    [self initProgressView:DOWNLOAD];
    [objManager downloadFolder];
}

-(void)stopSync
{
    [objManager clearSync];
    [self hideProgressBar];
}

-(void)stopRestore
{
    [objManager clearSession];
    [self hideProgressBar];
}

-(void)setProgress:(CGFloat)progress withMessage: (NSString *)message
{
    [HUD setProgress:progress animated:YES];
    HUD.status = message;
}

- (void)setComplete
{
    HUD.status = [Translator languageSelectedStringForKey:@"Done"];
    [HUD performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:1.5];
}

- (void)setDownloadComplete
{
    HUD.status = [Translator languageSelectedStringForKey:@"Done"];
    [HUD performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(resetWhenRestore) withObject:nil afterDelay:1.5];
}

- (void)setFailed: (NSString *) errorMes
{
    [HUD performAction:M13ProgressViewActionFailure animated:YES];
    HUD.status = errorMes;
    [self performSelector:@selector(reset) withObject:nil afterDelay:2.0];
}

-(void)hideProgressBar
{
    [HUD setProgress:0 animated:YES];
    [HUD hide:YES];
    //Enable other controls
    [modal hide];
}

- (void)resetWhenRestore
{
    [self hideProgressBar];
    [self showPasswordAlert];
}

-(void)showPasswordAlert
{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:[Translator languageSelectedStringForKey:@"PASSWORD"] message:[Translator languageSelectedStringForKey:@"Enter password which was used during last backup"] delegate:self cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"] otherButtonTitles: nil];
    alert.tag = 100;
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alert addButtonWithTitle:[Translator languageSelectedStringForKey:@"Enter"]];
    [alert show];
}

-(void)showErrorPasswordAlert
{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:[Translator languageSelectedStringForKey:@"Error!"]
                                                     message:[Translator languageSelectedStringForKey:@"Wrong password!"]
                                                    delegate:self
                                           cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"]
                          
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:[Translator languageSelectedStringForKey:@"Try again"]];
    alert.tag = 101;
    [alert show];

}

- (void)reset
{
    [self hideProgressBar];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case 100:
            if (buttonIndex == 1)
            {
                [HUD performAction:M13ProgressViewActionNone animated:YES];
                [modal show];
                [HUD show:YES];
                HUD.status = [Translator languageSelectedStringForKey:@"Unpacking"];
                dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
                dispatch_async(downloadQueue, ^{
                
                Sync *sync = [[Sync alloc] init];
                    sync.restoreDelegate = self;
                    
                UITextField *password = [alertView textFieldAtIndex:0];
                syncPasswd = password.text;
                int res = [sync RestoreBackup:syncPasswd];
                   
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (res == 0)
                        {
                            [HUD performAction:M13ProgressViewActionSuccess animated:YES];
                            [super performSelector:@selector(goToRoot) withObject:nil afterDelay:self.progressView.animationDuration + .3];
                        }
                        if (res == 1)
//                            [self showErrorPasswordAlert];
                        {
                            [self hideProgressBar];
//                            [self setFailed:[Translator languageSelectedStringForKey:@"Wrong password!"]];
                            [self showErrorPasswordAlert];
                            
                        }
                        
                        //поврежден файл с кэшем:
                        if (res == 4)
                            [self setFailed:[Translator languageSelectedStringForKey:@"Backup\nis corrupted!"]];

                    });
                
                });
            }

            break;
            
        case 101:
            
            if (buttonIndex == 0)
            {
                [self stopRestore];
            }
            
            if (buttonIndex == 1)
            {
                [self hideProgressBar];
                [self showPasswordAlert];
            }
            break;
    }
}

- (void)RestoreProcessed:(CGFloat)progress
{
    [HUD setProgress:progress animated:YES];
}

- (void) goToRoot
{
    [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedUploadFile
{
    [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.progressView.animationDuration + .2];
    [Settings setDateSync];
    self.lblLastBackup.text = [[Translator languageSelectedStringForKey:@"Last backup: "]  stringByAppendingString:[Settings getLastDateSync]];
    [Sync DeleteBackupFolder];
}

- (void)finishedDownloadFile
{
    [self performSelector:@selector(setDownloadComplete) withObject:nil afterDelay:self.progressView.animationDuration + .2];
}

- (void)failedToDownloadFile:(NSError *)error
{
    [objManager clearSession]; //stop load
    [self setFailedDependOnError:error];
}

- (void)downloadProgressed:(CGFloat)progress;
{
    [HUD setProgress:progress animated:YES];
    if (progress == 1.00)
    {
        HUD.status = [Translator languageSelectedStringForKey:@"Almost done"];
    }
}

- (void)failedToUploadFile:(NSError*)error
{
    [objManager clearSync]; //stop upload
    [self setFailedDependOnError:error];
}


-(void)setFailedDependOnError:(NSError*)error
{
    if (error.code == 100)
        [self setFailed:[Translator languageSelectedStringForKey:@"Canceled"]];
    
    else if (error.code == 401)
        [self setFailed:[Translator languageSelectedStringForKey:@"Re-auth\nplease"]];
    
    else if (error.code == 404)
    {
        [self setFailed:[Translator languageSelectedStringForKey:@"Backup\nwas not found!"]];
        [Settings deleteLastDateSync];
        self.lblLastBackup.text = @"";
    }
    else if (error.code == 507)
        [self setFailed:[Translator languageSelectedStringForKey:@"User is over Dropbox\nstorage quota"]];
    
    else if (error.code > 507)
        [self setFailed:[Translator languageSelectedStringForKey:@"Server error"]];
    
    else
        [self setFailed:[Translator languageSelectedStringForKey:@"Error!"]];
}

-(void)stopSyncing
{
    [objManager clearSync]; //stop upload
    [objManager clearSession]; //stop load
}

@end
