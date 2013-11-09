//
//  NoteVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAppearance.h"
#import "DocumentLib.h"
#import "NewDocViews.h"

@interface NoteVC : UIViewController
{
    Note *note;
}

@property (strong, nonatomic) IBOutlet UILabel *noteTitle;
@property (strong, nonatomic) IBOutlet UITextView *noteContent;

@property (strong, nonatomic) IBOutlet UIButton *deleteNote;
@property (strong, nonatomic) IBOutlet UIButton *sendNote;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblNote;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Note: (Note*) noteDoc;
@end
