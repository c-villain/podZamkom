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
    
    self.lblTitle.text = [Translator languageSelectedStringForKey:@"TITLE"];
    self.lblNote.text = [Translator languageSelectedStringForKey:@"NOTE"];
    
    [ViewAppearance setGlowToLabel:self.lblTitle];
    [ViewAppearance setGlowToLabel:self.lblNote];
    // Do any additional setup after loading the view from its nib.
    
    self.noteTitle.text = note.title;
    self.noteContent.text = note.content;
    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE NOTE"] forState:UIControlStateNormal];
    [self.sendBtn setTitle:[Translator languageSelectedStringForKey:@"SEND NOTE"] forState:UIControlStateNormal];
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: [Translator languageSelectedStringForKey:@"CONFIRM DELETION OF NOTE"]

                                                   message: nil
                                                  delegate: self
                                         cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"]
                                         otherButtonTitles:[Translator languageSelectedStringForKey:@"Delete"],nil];
    
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        if ([DBadapter DeleteDocument:note])
            [super showMainVC];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.noteContent.text;
    [super showMessageBoxWithTitle:[Translator languageSelectedStringForKey:@"Note was copied"]];
}

-(void)sendBtnTapped
{
    NSMutableString *message = [[NSMutableString alloc] init];
    [message appendString:[Translator languageSelectedStringForKey:@"Title: "]];
    [message appendString:note.title];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Note: "]];
    [message appendString:note.content];
    [super sendMessage:message];
}

@end
