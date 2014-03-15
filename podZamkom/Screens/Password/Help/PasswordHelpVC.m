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
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [navBar setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    [self.view addSubview:navBar];
    
    UIView *lbl = [ViewAppearance initViewWithGlowingTitle:[Translator languageSelectedStringForKey:@"FORGOT PASSWORD?"]];
    
    lbl.center = CGPointMake(navBar.center.x, navBar.center.y + 15);
    
    [navBar addSubview:lbl];
    
    //создаем кастомизированную кнопку back:
    UIButton *button = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    button.center = CGPointMake(navBar.center.x + 125, navBar.center.y + 13);
    [button addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [navBar addSubview:button];
    
    //создаем подсветку навбара
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 12)];
    iv.image= [UIImage imageNamed:@"line_under_title_bar.png"];
    [navBar addSubview:iv];
    
    self.helpText.text = [Translator languageSelectedStringForKey:@"First of all try to enter password with capital letters in different places. If it will not help you, you should reinstall application. Unfortunately all documents will be deleted after this."];
    self.helpText.textAlignment = NSTextAlignmentJustified;
    
}

-(void)backBtnTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
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
