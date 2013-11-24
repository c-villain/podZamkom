//
//  SettingsVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameVC.h"
#import "Security.h"
#import "DBlib.h"

@interface SettingsVC : FrameVC

@property (nonatomic, retain) IBOutlet UITextField *fieldWithPassword;
@property (nonatomic, retain) IBOutlet UITextField *fieldWithXtraPassword;
@property (nonatomic, retain) IBOutlet UIButton *visibleBtn; //кнопка скрытия/показа пароля
@property (nonatomic, retain) IBOutlet UIButton *xtraPasswdVisibleBtn; //кнопка скрытия/показа экстренного пароля

@property (nonatomic, retain) IBOutlet UISwitch *usePassword; //использовать пароль для входа
@property (nonatomic, retain) IBOutlet UISwitch *deleteFilesAfterTenErrors; // удалить данные после 10 ошибок

@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblXtraPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblLocalize;

@property (nonatomic, retain) IBOutlet UIButton *engSwitch;
@property (nonatomic, retain) IBOutlet UIButton *frSwitch;
@property (nonatomic, retain) IBOutlet UIButton *deSwitch;
@property (nonatomic, retain) IBOutlet UIButton *rusSwitch;

@end
