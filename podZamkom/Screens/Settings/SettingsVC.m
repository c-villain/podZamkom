//
//  SettingsVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "SettingsVC.h"

@implementation SettingsVC
@synthesize fieldWithPassword;
@synthesize fieldWithXtraPassword;
@synthesize usePassword;
@synthesize deleteFilesAfterTenErrors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) changeSecureTyping: (id)sender
{
    //меняем visible/invisible способ ввода пароля
    //по умолчанию ввод защищенный
    //поэтому если решили сменить ввод, то показываем пароль
    [self.visibleBtn setSelected:!self.visibleBtn.selected];
    [self.fieldWithPassword setSecureTextEntry:!self.fieldWithPassword.secureTextEntry];
}

- (IBAction) changeSecureTypingOfXtraPasswd: (id)sender
{
    //меняем visible/invisible способ ввода пароля
    //по умолчанию ввод защищенный
    //поэтому если решили сменить ввод, то показываем пароль
    [self.xtraPasswdVisibleBtn setSelected:!self.xtraPasswdVisibleBtn.selected];
    [self.fieldWithXtraPassword setSecureTextEntry:!self.fieldWithXtraPassword.secureTextEntry];
    
}

-(IBAction)switchLanguage:(id)sender
{
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    
    switch ([sender tag])
    {
        case 10:
            [userDefaults setObject:@"en" forKey:@"Language"];
            [userDefaults synchronize];
            break;
            
        case 11:
            [userDefaults setObject:@"de" forKey:@"Language"];
            [userDefaults synchronize];
            break;
            
        case 12:
            [userDefaults setObject:@"fr" forKey:@"Language"];
            [userDefaults synchronize];
            break;
            
        case 13:
            [userDefaults setObject:@"ru" forKey:@"Language"];
            [userDefaults synchronize];
            break;
            
            
            /*
             case 14:
             [userDefaults setObject:@"ar" forKey:@"Language"];
             [userDefaults synchronize];
             break;
             
             default:
             [userDefaults setObject:@"he" forKey:@"Language"];
             [userDefaults synchronize];
             break;
             */
            
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad:[super languageSelectedStringForKey:@"НАСТРОЙКИ"]];
    [ViewAppearance setGlowToLabel:self.lblPassword];
    [ViewAppearance setGlowToLabel:self.lblXtraPassword];
    [ViewAppearance setGlowToLabel:self.lblLocalize];

    self.fieldWithPassword.text = [Security getPassword];
    self.fieldWithXtraPassword.text = [Security getXtraPassword];
    self.usePassword.on = [Security getUseOrNotPassword];
    self.deleteFilesAfterTenErrors.on = [Security getDeleteorNotFilesAfterTenErrors];
    
    [self.engSwitch addTarget:self action:@selector(switchLanguage:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)saveBtnTapped
{
    //если не совпадает эстренный пароль с введенным, то сохраняем
    if (![self.fieldWithXtraPassword.text isEqualToString:[Security getXtraPassword]])
    {
        [Security saveXtraPassword:self.fieldWithXtraPassword.text];
    }
    //если не совпадает обычныый пароль с введенным, то сохраняем и перешифровываем базу:

    if (![self.fieldWithPassword.text isEqualToString:[Security getPassword]])
    {
        //TODO! перешифровка бд, если пароль изменился
        if ([DBadapter DBRecryptWithPassword:self.fieldWithPassword.text])
            [Security savePassword:self.fieldWithPassword.text];
    }
    
    [Security saveUseOrNotPassword:self.usePassword.on];
    [Security saveDeleteorNotFilesAfterTenErrors:self.deleteFilesAfterTenErrors.on];
    [super showMainVC];
}

-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"ПОДТВЕРДИТЕ УДАЛЕНИЕ"
                                                   message: @"всех данных"
                                                  delegate: self
                                         cancelButtonTitle:@"Отмена"
                                         otherButtonTitles:@"Удалить",nil];
    
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        if ([DBadapter DeleteAllDocs])
            [super showMainVC];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
