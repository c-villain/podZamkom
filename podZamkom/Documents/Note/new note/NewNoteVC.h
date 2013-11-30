//
//  NewNoteVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBlib.h"
#import "FrameVC.h"

@interface NewNoteVC : FrameVC

@property (strong) Note *selectedNote; //заметка для редактирования

@property (nonatomic, retain) IBOutlet UITextField *noteTitle;
@property (nonatomic, retain) IBOutlet UITextView *note;
    
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblNote;
    
@end
