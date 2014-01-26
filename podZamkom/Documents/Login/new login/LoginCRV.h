//
//  LoginCRV.h
//  podZamkom
//
//  Created by Alexander Kraev on 21.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "CollectionRV.h"

@interface LoginCRV : CollectionRV

@property (nonatomic, retain) IBOutlet UITextField *urlField;
@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextView *loginNote;

@property (nonatomic, retain) IBOutlet UILabel *lblUrl;
@property (nonatomic, retain) IBOutlet UILabel *lblLogin;
@property (nonatomic, retain) IBOutlet UILabel *lblPassword;
@property (nonatomic, retain) IBOutlet UILabel *lblComment;

@end
