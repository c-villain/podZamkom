//
//  SettingsVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/utsname.h> 
#import "FrameVC.h"
#import "Security.h"
#import "DBlib.h"
#import <MessageUI/MessageUI.h> 
#import "Settings.h"

@interface SettingsVC : FrameVC <RecryptDelegate, MFMailComposeViewControllerDelegate>
{
    NSString *selectedLanguage;
}

- (IBAction)showEmail:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *fieldWithPassword;
@property (nonatomic, retain) IBOutlet UITextField *fieldWithXtraPassword;
@property (nonatomic, retain) IBOutlet UIButton *visibleBtn; //кнопка скрытия/показа пароля

@property (nonatomic, retain) IBOutlet UIButton *sendMailBtn; //кнопка написать разрабочткам

@property (nonatomic, retain) IBOutlet UIButton *syncDropBoxBtn; //кнопка sync с дропбоксом

@property (nonatomic, retain) IBOutlet UIButton *voteAppBtn; //кнопка голосования

@property (nonatomic, retain) IBOutlet UIButton *syncBtn; //кнопка синхронизации

@property (nonatomic, retain) IBOutlet UIButton *xtraPasswdVisibleBtn; //кнопка скрытия/показа экстренного пароля

@property (nonatomic, retain) IBOutlet UISwitch *usePassword; //использовать пароль для входа
@property (nonatomic, retain) IBOutlet UISwitch *deleteFilesAfterTenErrors; // удалить данные после 10 ошибок

@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblXtraPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblLocalize;

@property (strong, nonatomic) IBOutlet UILabel *lblUsePassword;
@property (strong, nonatomic) IBOutlet UILabel *lblDeleteDocs;
@property (strong, nonatomic) IBOutlet UILabel *lblXtraPasswdDesription;

@property (nonatomic, retain) IBOutlet UIButton *engSwitch;
@property (nonatomic, retain) IBOutlet UIButton *frSwitch;
@property (nonatomic, retain) IBOutlet UIButton *deSwitch;
@property (nonatomic, retain) IBOutlet UIButton *rusSwitch;

@end
