//
//  NewPassportVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameVC.h"
#import "DBlib.h"
#import "TextField.h"
#import "Picker.h"

@interface NewPassportVC : FrameVC
{
    NSArray *country; //массив типов платежных систем
}

@property (strong) Passport *selectedPassport; //заметка для редактирования

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *countryField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UITextView *depField;
@property (strong, nonatomic) IBOutlet UITextField *dateIssueField;
@property (strong, nonatomic) IBOutlet UITextField *depCodeField;
@property (strong, nonatomic) IBOutlet UITextField *holderField;
@property (strong, nonatomic) IBOutlet UITextField *birthDateField;
@property (strong, nonatomic) IBOutlet UITextView *birthPlaceField;


@end
