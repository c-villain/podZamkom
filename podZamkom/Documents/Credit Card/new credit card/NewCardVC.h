//
//  NewCardVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameVC.h"
#import "DBlib.h"
#import "TextField.h"
#import "Picker.h"

@interface NewCardVC : FrameVC
{
     NSArray *cardTypes; //массив типов платежных систем
}

@property (strong) CreditCard *selectedCreditCard; //заметка для редактирования

@property (strong, nonatomic) IBOutlet UITextField *bankField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UITextField *typeField;
@property (strong, nonatomic) IBOutlet UITextField *validThruDate;
@property (strong, nonatomic) IBOutlet UITextField *cardHolderField;
@property (strong, nonatomic) IBOutlet UITextField *cvcField;
@property (strong, nonatomic) IBOutlet UITextField *pinField;
@property (strong, nonatomic) IBOutlet UITextField *colorField;
@property (strong, nonatomic) IBOutlet UITextView *commentField;

@end
