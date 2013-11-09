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
    
    [super viewDidLoad:@"НОВЫЙ ЛОГИН"];
	// Do any additional setup after loading the view.
    
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
    //    TODO!
    NSLog(@"SAVE!");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
