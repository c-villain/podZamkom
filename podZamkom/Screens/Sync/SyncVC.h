//
//  SyncVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 29.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "FrameVC.h"
//#import <DropboxSDK/DropboxSDK.h>
#import <Dropbox/Dropbox.h>
#import "AppDelegate.h"
#import "Sync.h"

@interface SyncVC : FrameVC <DropboxSyncDelegate>
{
//    DropboxManager *objManager;
}
@property (nonatomic, retain) IBOutlet UISwitch *dropboxSync; //использовать пароль для входа

@property (nonatomic, retain) IBOutlet UIButton *createBackupBtn; //кнопка создать backup
@property (nonatomic, retain) IBOutlet UIButton *restoreBackupBtn; //восстановить из копии
@property (strong, nonatomic) IBOutlet UILabel *lblLastBackup;  //строка последняя копия

@end
