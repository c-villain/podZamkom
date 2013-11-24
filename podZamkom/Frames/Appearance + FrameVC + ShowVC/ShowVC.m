//
//  ShowVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ShowVC.h"

@interface ShowVC ()

@end

@implementation ShowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad: (NSString*)title
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:title];
    //создаем кастомизированную кнопку back:
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_back.png"];
    [backButton addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    UIButton *saveButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_edit.png"];
    [saveButton addTarget:self action:@selector(editBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];
    
}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMainVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//метод для переопределения каждый в своем классе:
-(void)editBtnTapped
{
}

- (IBAction) deleteDoc: (id)sender
{
    [self deleteBtnTapped];
}

-(void)deleteBtnTapped
{
}

- (IBAction) copyDoc: (id)sender
{
    [self copyBtnTapped:sender];
}

-(void)copyBtnTapped:(id)sender
{
}

-(void)showMessageBoxWithTitle:(NSString*)title
{
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithLogo:@"title_bar_icon_save.png" withTitle:title message:nil];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal showWithDuration:0.3f delay:0.4 options:UIViewAnimationOptionTransitionNone completion:^{
        [modal hideWithDuration:0.3f delay:0.4 options:UIViewAnimationOptionTransitionNone completion:nil];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
