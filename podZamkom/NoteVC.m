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
    [super viewDidLoad: note.title];
    
    // Do any additional setup after loading the view from its nib.
    
    self.noteTitle.text = note.title;
    self.noteContent.text = note.content;
    
    [ViewAppearance setGlowToLabel:self.lblTitle];
    [ViewAppearance setGlowToLabel:self.lblNote];
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewNoteVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newNote"];
    myController.selectedNote = note;
    [self.navigationController pushViewController:myController animated:YES];
}

-(void)deleteBtnTapped
{
    if ([DBadapter DeleteDocument:note])
        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
