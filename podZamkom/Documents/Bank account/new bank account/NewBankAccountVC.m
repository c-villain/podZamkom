//
//  NewBankAccountVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewBankAccountVC.h"

@implementation NewBankAccountVC

- (void)viewDidLoad
{
    NSString* title = [Translator languageSelectedStringForKey:@"NEW BANK ACCOUNT"];
    
    self.lblBank.text = [Translator languageSelectedStringForKey:@"BANK"];
    self.lblBankAccount.text = [Translator languageSelectedStringForKey:@"BANK ACCOUNT"];
    self.lblCurrency.text = [Translator languageSelectedStringForKey:@"CURRENCY"];
    self.lblBIKCode.text = [Translator languageSelectedStringForKey:@"BIK CODE"];
    self.lblCorrespondentAccount.text = [Translator languageSelectedStringForKey:@"CORRESPONDENT ACCOUNT"];
    self.lblTaxpayerID.text = [Translator languageSelectedStringForKey:@"TAXPAYER ID"];
    self.lblTaxRegistrationReasonCode.text = [Translator languageSelectedStringForKey:@"TAX REGISTRATION REASON CODE"];
    self.lblComments.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
    
    //забиваем маску для нужных текстовых полей:
    [(TextField *)self.innField initWithMask:@"999999999999"];
    [(TextField *)self.bikField initWithMask:@"999999999"];
    [(TextField *)self.kppField initWithMask:@"99999 9999"];
    [(TextField *)self.accountField initWithMask:@"99999 99999 99999 99999"];
    [(TextField *)self.corNumberField initWithMask:@"99999 99999 99999 99999"];
    
    //инициализируем пикеры (цвета и типа):
    ((TextField *)self.curTypeField).picker = [Picker createPickerWithData:[CurrencyType initCurrencyTypeArray] andPickerDelegate:self];

    //по умолч. ставим везде пустые текстовые поля:
    self.bankField.text = @"";
    self.accountField.text = @"";
    self.curTypeField.text = @"";
    self.bikField.text = @"";
    self.corNumberField.text = @"";
    self.innField.text = @"";
    self.kppField.text = @"";
    self.commentField.text = @"";
    
    [self.bankField becomeFirstResponder];
    
    //если же мы находимся в режиме редактирования, то заполняем все поля:
    if (self.selectedBankAccount != nil)
    {
        title = self.selectedBankAccount.bank;
        self.bankField.text = self.selectedBankAccount.bank;
        self.accountField.text = self.selectedBankAccount.accountNumber;
        [super showInTextField:self.curTypeField selectedPickerObject:[CurrencyType initCurrencyTypeArray][self.selectedBankAccount.curType]];
        self.bikField.text = self.selectedBankAccount.bik;
        self.corNumberField.text = self.selectedBankAccount.corNumber;
        self.innField.text = self.selectedBankAccount.inn;
        self.kppField.text = self.selectedBankAccount.kpp;
        self.commentField.text = self.selectedBankAccount.comments;
    }
    [super viewDidLoad:title];
}

-(void)saveBtnTapped
{
    BankAccount *account = [BankAccount new];
    account.idDoc = self.selectedBankAccount.idDoc;
    account.docType = BankAccountDoc;
    account.bank = [Translator languageSelectedStringForKey:@"Bank account"];
    if (![[self.bankField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
        account.bank = self.bankField.text;
    
    account.accountNumber = self.accountField.text;
    account.curType = ( (Picker *) ((TextField *)self.curTypeField).picker).selectedIndex;
    account.bik = self.bikField.text;
    account.corNumber = self.corNumberField.text;
    account.inn = self.innField.text;
    account.kpp = self.kppField.text;
    account.comments = self.commentField.text;
    
    if ([DBadapter DBSave:account])
        [super showMainVC];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
