//
//  NewNoteVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewNoteVC.h"

@implementation NewNoteVC

- (void)viewDidLoad
{
    [super viewDidLoad:@"НОВАЯ ЗАМЕТКА"];
	// Do any additional setup after loading the view.
    
    self.noteTitle.text = @"";
    self.note.text = @"";
    
    if (self.selectedNote != nil)
    {
        self.noteTitle.text = self.selectedNote.title;
        self.note.text = self.selectedNote.content;
    }
    [self.noteTitle becomeFirstResponder];
}

-(void)saveBtnTapped
{
    DBadapter *db = [[DBadapter alloc] init];
    [db SaveNote:self.noteTitle.text withContent:self.note.text];
//    if (YES == [db SaveNote:self.fieldTitle.text withContent:self.fieldNote.text])
//        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
