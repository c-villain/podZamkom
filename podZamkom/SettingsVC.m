//
//  SettingsVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //устанавливаем цвет navbar-а:
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:@"НАСТРОЙКИ"];
    //создаем кастомизированную кнопку back:
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    [backButton addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    UIButton *saveButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_save.png"];
    [saveButton addTarget:self action:@selector(saveBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;

    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];

}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
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
