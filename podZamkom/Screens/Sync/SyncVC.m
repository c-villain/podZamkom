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
//    if (objManager == nil)
//    {
//        objManager = [DropboxManager dropBoxManager];
//        objManager.apiCallDelegate =self;
//        [objManager initDropbox];
//    }
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
//            objManager = [DropboxManager dropBoxManager];
//            objManager.apiCallDelegate =self;
//            [objManager initDropbox];
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
    /*
    //создаем файл бэкапа базы данных и справочной информации для последующей синхронизации:
    [Sync CreateBackup];

    objManager.currentPostType = DropBoxUploadFile;
    
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    NSString *dbDir = [dbPath objectAtIndex:0];
//    dbDir = [dbDir stringByAppendingPathComponent:@"Backup"];
    
    NSLog(@"%@",dbDir);
    dbDir = [dbDir stringByAppendingPathComponent:@"backup.sqlite"];
    objManager.strFileName  = [NSString stringWithFormat:@"backup.sqlite"];;
    objManager.strFilePath = dbDir;
    objManager.strDestDirectory = @"/Under lock/Backup";
    [objManager uploadFile];
     */
    
    //создаем файл бэкапа базы данных и справочной информации для последующей синхронизации:
    [Sync CreateBackup];
    
    objManager.currentPostType = DropBoxUploadFile;
    
    NSArray *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    NSString *dbDir = [dbPath objectAtIndex:0];
        dbDir = [dbDir stringByAppendingPathComponent:@"Backup"];
    objManager.strFilePath = dbDir;
    objManager.strDestDirectory = @"/Backup";
    [objManager syncFolder];
    
}

- (IBAction)restoreBackup:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)finishedUploadFile
{
    NSLog(@"Uploaded successfully.");
}

- (void)failedToUploadFile:(NSString*)withMessage
{
    NSLog(@"Failed to upload error is %@",withMessage);
}
 
@end
