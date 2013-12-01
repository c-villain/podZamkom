//
//  NewLoginVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewLoginVC.h"

@implementation NewLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad:[Translator languageSelectedStringForKey:@"NEW LOGIN"]];
	// Do any additional setup after loading the view.
    
    self.lblUrl.text = [Translator languageSelectedStringForKey:@"URL"];
    self.lblLogin.text = [Translator languageSelectedStringForKey:@"LOGIN"];
    self.lblPassword.text = [Translator languageSelectedStringForKey:@"PASSWORD"];
    self.lblComment.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
    
    self.urlField.text = @"";
    self.loginField.text = @"";
    self.passwordField.text = @"";
    self.loginNote.text = @"";
    
    if (self.selectedLogin != nil)
    {
        self.urlField.text = self.selectedLogin.url;
        self.loginField.text = self.selectedLogin.login;
        self.passwordField.text = self.selectedLogin.password;
        self.loginNote.text = self.selectedLogin.comment;
    }
    [self.urlField becomeFirstResponder];
}


-(void)saveBtnTapped
{
    Login *login = [Login new];
    login.idDoc = self.selectedLogin.idDoc;
    login.url = [Translator languageSelectedStringForKey:@"Login"];

    if (![[self.urlField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
        login.url = self.urlField.text;
    
    login.login = self.loginField.text;
    login.password = self.passwordField.text;
    login.comment = self.loginNote.text;
    login.docType = LoginDoc;
    if ([DBadapter DBSave:login])
        [super showMainVC];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
