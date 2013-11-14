//
//  BankAccountVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 13.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "BankAccountVC.h"

@implementation BankAccountVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil BankAccount:(BankAccount*) bankAccountDoc;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bankAccount = bankAccountDoc;
    }
    return self;
}

- (NSString *)getStringWithNumber:(NSString *)number andCurrency:(CurrencyTypeEnum) curType
{
    NSString *numberWithCur = number;
    numberWithCur = [numberWithCur stringByAppendingString: @" ("];
    numberWithCur = [numberWithCur stringByAppendingString:[CurrencyType getCurrencyByType:curType].name];
    numberWithCur = [numberWithCur stringByAppendingString: @")"];
    return numberWithCur;
}

- (void)viewDidLoad
{
    [super viewDidLoad: bankAccount.bank];
    // Do any additional setup after loading the view from its nib.
    [ViewAppearance setGlowToLabel:self.lblBank];
    [ViewAppearance setGlowToLabel:self.lblBik];
    [ViewAppearance setGlowToLabel:self.lblInn];
    [ViewAppearance setGlowToLabel:self.lblKpp];
    [ViewAppearance setGlowToLabel:self.lblCorNumber];
    [ViewAppearance setGlowToLabel:self.lblComment];
    
    //забиваю значения:
    self.lblBank.text = bankAccount.bank;
    self.accountNumberField.text = [self getStringWithNumber:bankAccount.accountNumber andCurrency:bankAccount.curType];
    self.bikField.text = bankAccount.bik;
    self.innField.text = bankAccount.inn;
    self.kppField.text = bankAccount.kpp;
    self.corNumberField.text = bankAccount.corNumber;
    self.bankAccountComment.text = bankAccount.comments;
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewBankAccountVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newBankAccount"];
    myController.selectedBankAccount = bankAccount;
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
