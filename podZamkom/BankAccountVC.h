//
//  BankAccountVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 13.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ShowVC.h"
#import "ShowVC.h"

@interface BankAccountVC : ShowVC
{
    BankAccount *bankAccount;
}

@property (strong, nonatomic) IBOutlet UILabel *lblBank;
@property (strong, nonatomic) IBOutlet UILabel *accountNumberField;
@property (strong, nonatomic) IBOutlet UILabel *lblBik;
@property (strong, nonatomic) IBOutlet UILabel *bikField;
@property (strong, nonatomic) IBOutlet UILabel *lblInn;
@property (strong, nonatomic) IBOutlet UILabel *innField;
@property (strong, nonatomic) IBOutlet UILabel *lblKpp;
@property (strong, nonatomic) IBOutlet UILabel *kppField;
@property (strong, nonatomic) IBOutlet UILabel *lblCorNumber;
@property (strong, nonatomic) IBOutlet UILabel *corNumberField;
@property (strong, nonatomic) IBOutlet UILabel *lblComment;
@property (strong, nonatomic) IBOutlet UITextView *bankAccountComment;

@property (strong, nonatomic) IBOutlet UIButton *sendBankAccount;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil BankAccount:(BankAccount*) bankAccountDoc;

@end
