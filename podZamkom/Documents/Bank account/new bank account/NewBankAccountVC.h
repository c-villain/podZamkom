//
//  NewBankAccountVC.h
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

@interface NewBankAccountVC : FrameVC
{
    NSArray *curTypes; //массив типов валют
}

@property (strong) BankAccount *selectedBankAccount; //заметка для редактирования

@property (strong, nonatomic) IBOutlet UITextField *bankField;
@property (strong, nonatomic) IBOutlet UITextField *accountField;
@property (strong, nonatomic) IBOutlet UITextField *curTypeField;
@property (strong, nonatomic) IBOutlet UITextField *bikField;
@property (strong, nonatomic) IBOutlet UITextField *corNumberField;
@property (strong, nonatomic) IBOutlet UITextField *innField;
@property (strong, nonatomic) IBOutlet UITextField *kppField;
@property (strong, nonatomic) IBOutlet UITextView *commentField;

    @property (nonatomic, retain) IBOutlet UILabel *lblBank;
    @property (nonatomic, retain) IBOutlet UILabel *lblBankAccount;
    @property (nonatomic, retain) IBOutlet UILabel *lblCurrency;
    @property (nonatomic, retain) IBOutlet UILabel *lblBIKCode;
    @property (nonatomic, retain) IBOutlet UILabel *lblCorrespondentAccount;
    @property (nonatomic, retain) IBOutlet UILabel *lblTaxpayerID;
    @property (nonatomic, retain) IBOutlet UILabel *lblTaxRegistrationReasonCode;
    @property (nonatomic, retain) IBOutlet UILabel *lblComments;
    
@end
