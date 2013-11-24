//
//  LoginVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 03.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowVC.h"

@interface LoginVC : ShowVC
{
    Login *login;
}

@property (strong, nonatomic) IBOutlet UILabel *loginUrl;
@property (strong, nonatomic) IBOutlet UILabel *loginLogin;
@property (nonatomic, retain) IBOutlet UITextField *loginPassword;
@property (strong, nonatomic) IBOutlet UILabel *loginComments;
@property (strong, nonatomic) IBOutlet UILabel *lblUrl;
@property (strong, nonatomic) IBOutlet UILabel *lblLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblComment;
@property (strong, nonatomic) IBOutlet UITextView *loginComment;

@property (nonatomic, retain) IBOutlet UIButton *visibleBtn;
- (IBAction) changeSecureTyping: (id)sender; //изменение текстового поля для пароля

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Login: (Login*) loginDoc;

@end
