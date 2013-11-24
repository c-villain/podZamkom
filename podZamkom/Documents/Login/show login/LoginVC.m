//
//  LoginVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 03.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Login: (Login*) loginDoc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        login = loginDoc;
    }
    return self;
}

- (IBAction) changeSecureTyping: (id)sender
{
    //меняем visible/invisible способ ввода пароля
    //по умолчанию ввод защищенный
    //поэтому если решили сменить ввод, то показываем пароль
    [self.visibleBtn setSelected:!self.visibleBtn.selected];
    [_loginPassword setSecureTextEntry:!_loginPassword.secureTextEntry];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad: login.url];
    // Do any additional setup after loading the view from its nib.
    
    self.loginUrl.text = login.url;
    self.loginLogin.text = login.login;
    self.loginPassword.text = login.password;
    self.loginComment.text = login.comment;
    
    [ViewAppearance setGlowToLabel:self.lblUrl];
    [ViewAppearance setGlowToLabel:self.lblLogin];
    [ViewAppearance setGlowToLabel:self.lblPassword];
    [ViewAppearance setGlowToLabel:self.lblComment];
    
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewLoginVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newLogin"];
    myController.selectedLogin = login;
    [self.navigationController pushViewController:myController animated:YES];
}

-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"ПОДТВЕРДИТЕ УДАЛЕНИЕ"
                                                   message: @"Логин"
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
        if ([DBadapter DeleteDocument:login])
            [super showMainVC];
    }
}

-(void)copyBtnTapped
{
    NSString *url = self.loginUrl.text;
    if ([[self.loginUrl.text lowercaseString] rangeOfString:@"http://"].location == NSNotFound)
        url = [NSString stringWithFormat:@"http://%@",self.loginUrl.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
