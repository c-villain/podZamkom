//
//  NewLoginVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBlib.h"
#import "FrameVC.h"

@interface NewLoginVC : FrameVC

@property (strong) Login *selectedLogin; //заметка для редактирования

@property (nonatomic, retain) IBOutlet UITextField *urlField;
@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextView *loginNote;

@end
