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
    NSString* title = [Translator languageSelectedStringForKey:@"NEW NOTE"];
    
    self.lblTitle.text = [Translator languageSelectedStringForKey:@"TITLE"];
    self.lblNote.text = [Translator languageSelectedStringForKey:@"NOTE"];
    
	// Do any additional setup after loading the view.
    
    self.noteTitle.text = @"";
    self.note.text = @"";
    [self.noteTitle becomeFirstResponder];
    
    if (self.selectedNote != nil)
    {
        title = self.selectedNote.title;
        self.noteTitle.text = self.selectedNote.title;
        self.note.text = self.selectedNote.content;
    }
    
    [super viewDidLoad:title];
}

-(void)saveBtnTapped
{
    Note *note = [Note new];
    note.idDoc = self.selectedNote.idDoc;
    note.title = @"Заметка";
    if (![[self.noteTitle.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
        note.title = self.noteTitle.text;
    note.content = self.note.text;
    note.docType = NoteDoc;
    if ([DBadapter DBSave:note])
        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
