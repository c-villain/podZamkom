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
        document = noteDoc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad: ((Note *)document).title];
    
    self.lblTitle.text = [Translator languageSelectedStringForKey:@"TITLE"];
    self.lblNote.text = [Translator languageSelectedStringForKey:@"NOTE"];
    
    [ViewAppearance setGlowToLabel:self.lblTitle];
    [ViewAppearance setGlowToLabel:self.lblNote];
    // Do any additional setup after loading the view from its nib.
    
    self.noteTitle.text = ((Note *)document).title;
    self.noteContent.text = ((Note *)document).content;
    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE NOTE"] forState:UIControlStateNormal];
    [self.sendBtn setTitle:[Translator languageSelectedStringForKey:@"SEND NOTE"] forState:UIControlStateNormal];
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
        if ([DBadapter DeleteDocument:((Note *)document)])
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
    [message appendString:((Note *)document).title];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Note: "]];
    [message appendString:((Note *)document).content];
    [super sendMessage:message];
}

@end
