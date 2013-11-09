//
//  NoteVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NoteVC.h"

@implementation NoteVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Note: (Note*) noteDoc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        note = noteDoc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:@"ЗАМЕТКА"];
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
    
    self.noteTitle.text = note.title;
    self.noteContent.text = note.content;
    
    [ViewAppearance setGlowToLabel:self.lblTitle];
    [ViewAppearance setGlowToLabel:self.lblNote];
}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewNoteVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newNote"];
    myController.selectedNote = note;
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
