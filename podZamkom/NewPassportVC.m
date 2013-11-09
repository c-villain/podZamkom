//
//  NewPassportVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewPassportVC.h"

@interface NewPassportVC ()

@end

@implementation NewPassportVC

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
    
    [super viewDidLoad:@"НОВЫЙ ПАСПОРТ"];
	// Do any additional setup after loading the view.
    
    //    self.enhancedKeyboard = [[KSEnhancedKeyboard alloc] init];
    //    self.enhancedKeyboard.delegate = self;
//    [self.noteTitle becomeFirstResponder];
    
    //    TODO!
//    if (self.selectedNote != nil)
//    {
//        self.noteTitle.text = self.selectedNote.title;
//        self.note.text = self.selectedNote.content;
//    }

    
    /*
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:@"НОВЫЙ ПАСПОРТ"];
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
    */
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
