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
- (void)viewDidLoad
{
    [super viewDidLoad: @"НАСТРОЙКИ"];
    [ViewAppearance setGlowToLabel:self.lblPassword];
    [ViewAppearance setGlowToLabel:self.lblXtraPassword];
    [ViewAppearance setGlowToLabel:self.lblLocalize];

    self.fieldWithPassword.text = [Security getPassword];
    self.fieldWithXtraPassword.text = [Security getXtraPassword];
    self.usePassword.on = [Security getUseOrNotPassword];
    self.deleteFilesAfterTenErrors.on = [Security getDeleteorNotFilesAfterTenErrors];
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
    if ([DBadapter DeleteAllDocs])
        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
