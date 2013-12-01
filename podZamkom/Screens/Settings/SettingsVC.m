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
    [self highlightButtonWithLanguage:sender];
}

- (void)highlightButtonWithLanguage:(id)sender
{
    [self dehiglightButtonsWithLanguages];
    UIButton* languageBtn;
    switch ([sender tag])
    {
        case 10:
            languageBtn = self.engSwitch;
            selectedLanguage = @"en";
            break;
            
        case 11:
            languageBtn = self.deSwitch;
            selectedLanguage = @"de";
            break;
            
        case 12:
            languageBtn = self.frSwitch;
            selectedLanguage = @"fr";
            break;
            
        case 13:
            languageBtn = self.rusSwitch;
            selectedLanguage = @"ru";
            break;
    }
    languageBtn.backgroundColor = [UIColor colorWithRed:72.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

- (void)highlightButtonWithLanguage
{
    [self dehiglightButtonsWithLanguages];
    UIButton* languageBtn;
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:@"Language"];
    if ([language  isEqual: @"ru"])
        languageBtn = self.rusSwitch;
    if ([language  isEqual: @"de"])
        languageBtn = self.deSwitch;
    if ([language  isEqual: @"fr"])
        languageBtn = self.frSwitch;
    if ([language  isEqual: @"en"])
        languageBtn = self.engSwitch;
    languageBtn.backgroundColor = [UIColor colorWithRed:72.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}


-(void)dehiglightButtonsWithLanguages
{
    UIColor *bg = [UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
    self.rusSwitch.backgroundColor = bg;
    self.deSwitch.backgroundColor = bg;
    self.frSwitch.backgroundColor = bg;
    self.engSwitch.backgroundColor = bg;
}


- (void)viewDidLoad
{
//    [super viewDidLoad:[super languageSelectedStringForKey:[Translator languageSelectedStringForKey:@"SETTINGS"]]];
    [super viewDidLoad:[Translator languageSelectedStringForKey:@"SETTINGS"]];
    self.lblPassword.text = [Translator languageSelectedStringForKey:@"PASSWORD"];
    self.lblXtraPassword.text = [Translator languageSelectedStringForKey:@"EMERGENCY PASSWORD"];
    self.lblLocalize.text = [Translator languageSelectedStringForKey:@"LANGUAGE"];
    
    [ViewAppearance setGlowToLabel:self.lblPassword];
    [ViewAppearance setGlowToLabel:self.lblXtraPassword];
    [ViewAppearance setGlowToLabel:self.lblLocalize];

    self.lblUsePassword.text = [Translator languageSelectedStringForKey:@"Every time ask for logging in (recommended)"];
    self.lblDeleteDocs.text = [Translator languageSelectedStringForKey:@"Delete documents after tenth attempt to enter password"];
    self.lblXtraPasswdDesription.text = [Translator languageSelectedStringForKey:@"After entering this password all documents will be deleted"];
    
    self.fieldWithPassword.text = [Security getPassword];
    self.fieldWithXtraPassword.text = [Security getXtraPassword];
    self.usePassword.on = [Security getUseOrNotPassword];
    self.deleteFilesAfterTenErrors.on = [Security getDeleteorNotFilesAfterTenErrors];
    
    [self.engSwitch addTarget:self action:@selector(switchLanguage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE ALL"] forState:UIControlStateNormal];
    
    [self highlightButtonWithLanguage];
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
        if ([DBadapter DBRecryptWithPassword:self.fieldWithPassword.text])
            [Security savePassword:self.fieldWithPassword.text];
    }
    
    [Security saveUseOrNotPassword:self.usePassword.on];
    [Security saveDeleteorNotFilesAfterTenErrors:self.deleteFilesAfterTenErrors.on];
    
    //сохраняем выбранный язык для локализации:
    [Settings saveSelectedLanguage:selectedLanguage];
    [super showMainVC];
}

-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: [Translator languageSelectedStringForKey:@"CONFIRM DELETION OF ALL DOCUMENTS"]
                                                   message: nil
                                                  delegate: self
                                         cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"]
                                         otherButtonTitles:[Translator languageSelectedStringForKey:@"Delete"],nil];
    
    
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
