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
        filesDownloaded = 0;
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
    }

}

- (IBAction)syncWithDropBox:(id)sender
{
    if ([self.dropboxSync isOn])
    {
        if (![self CheckIfDropBoxAccountIsLinked])
        {
            [objManager checkForLink];
        }
        else
            [self setButtonsVisibility:YES];    }
    else
    {
        if (objManager)
            [objManager logoutFromDropbox];
        [self setButtonsVisibility:NO];
    }
    
}

- (IBAction)createBackup:(id)sender
{
    CGRect size = CGRectMake(0, 0 , 150, 150);
    HUD = [[[M13ProgressHUD alloc] initWithFrame:size] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    HUD.progressViewSize = CGSizeMake(60.0, 60.0);
    modal = [[RNBlurModalView alloc] initWithView:HUD];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal show];
    [HUD show:YES];
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
    HUD.status = @"Загружаю";
    [objManager uploadFolder];
}

- (IBAction)restoreBackup:(id)sender
{
    CGRect size = CGRectMake(0, 0 , 150, 150);
    HUD = [[[M13ProgressHUD alloc] initWithFrame:size] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    HUD.progressViewSize = CGSizeMake(60.0, 60.0);
    modal = [[RNBlurModalView alloc] initWithView:HUD];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal show];
    [HUD show:YES];
    HUD.status = @"Загружаю";
    [objManager downloadFolder];
}

-(void)setProgress:(CGFloat)progress withMessage: (NSString *)message
{
    [HUD setProgress:progress animated:YES];
    HUD.status = message;
}

- (void)setComplete
{
    HUD.status = @"Готово!";
    [HUD performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:1.5];
}

- (void)setFailed: (NSString *) errorMes
{
    [HUD performAction:M13ProgressViewActionFailure animated:YES];
    HUD.status = errorMes;
    [self performSelector:@selector(reset) withObject:nil afterDelay:1.5];
}

- (void)reset
{
    [HUD hide:YES];
    //Enable other controls
    [modal hide];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UITextField *password = [alertView textFieldAtIndex:0];
        syncPasswd = password.text;
        int res = [Sync RestoreBackup:syncPasswd];
        if (res == 0) [super showMainVC];
        if (res == 1)
        {
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:[Translator languageSelectedStringForKey:@"Error!"]
                                                             message:[Translator languageSelectedStringForKey:@"Wrong password!"]
                                                            delegate:self
                                                   cancelButtonTitle:[Translator languageSelectedStringForKey:@"Try again"]
                                                   otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedUploadFile
{
    filesDownloaded++;
    if (filesDownloaded == 2)
    {
        [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.progressView.animationDuration + .2];
//        [HUD setProgress:1.0 animated:YES];
        filesDownloaded = 0;
        [Settings setDateSync];
        self.lblLastBackup.text = [[Translator languageSelectedStringForKey:@"Last backup: "]  stringByAppendingString:[Settings getLastDateSync]];
        [Sync DeleteBackupFolder];
//        [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .1];
    }
}

- (void)finishedDownloadFile
{
    filesDownloaded++;
    if (filesDownloaded == 2)
    {
        [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.progressView.animationDuration + .2];
        filesDownloaded = 0;
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:[Translator languageSelectedStringForKey:@"PASSWORD"] message:[Translator languageSelectedStringForKey:@"Enter password which was used during last backup"] delegate:self cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"] otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert addButtonWithTitle:[Translator languageSelectedStringForKey:@"Enter"]];
        [alert show];
    }
}

- (void)downloadProgressed:(CGFloat)progress;
{
    [HUD setProgress:progress animated:YES];
    if (progress == 1.00)
        HUD.status = @"Завершаю";
//        [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.progressView.animationDuration + .2];
}


- (void)failedToUploadFile:(NSString*)withMessage
{
    [self setFailed: withMessage];
}
 
@end
