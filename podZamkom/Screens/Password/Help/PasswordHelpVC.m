//
//  PasswordHelpVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 08.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PasswordHelpVC.h"

@interface PasswordHelpVC ()

@end

@implementation PasswordHelpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //устанавливаем цвет navbar-а:
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.hidesBackButton = YES;

    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:[Translator languageSelectedStringForKey:@"FORGOT PASSWORD?"]];
    
    //создаем кастомизированную кнопку back:
    UIButton *button = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    [button addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];
    self.helpText.text = [Translator languageSelectedStringForKey:@"First of all try to enter password with capital letters in different places. If it will not help you, you should reinstall application. Unfortunately all documents will be deleted after this."];
    
}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
