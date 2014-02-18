//
//  SyncVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 29.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "FrameVC.h"
#import "DropboxManager.h"
#import "AppDelegate.h"
#import "Sync.h"
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"

@interface SyncVC : FrameVC <DropBoxDelegate, DropboxSyncDelegate, UIAlertViewDelegate>
{
    DropboxManager *objManager;
    NSString *syncPasswd;
    int filesDownloaded;
    M13ProgressHUD *HUD;
    RNBlurModalView *modal;
}

@property (strong, nonatomic) IBOutlet UILabel *lblDropboxSync;
@property (nonatomic, retain) IBOutlet UISwitch *dropboxSync; //использовать пароль для входа

@property (nonatomic, retain) IBOutlet UIButton *createBackupBtn; //кнопка создать backup
@property (nonatomic, retain) IBOutlet UIButton *restoreBackupBtn; //восстановить из копии
@property (strong, nonatomic) IBOutlet UILabel *lblLastBackup;  //строка последняя копия

@end
