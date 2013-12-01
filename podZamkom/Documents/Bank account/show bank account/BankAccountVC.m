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
    self.lblBik.text = [Translator languageSelectedStringForKey:@"BIK CODE"];
    
    [ViewAppearance setGlowToLabel:self.lblInn];
    self.lblInn.text = [Translator languageSelectedStringForKey:@"TAXPAYER ID"];
    
    [ViewAppearance setGlowToLabel:self.lblKpp];
    self.lblKpp.text = [Translator languageSelectedStringForKey:@"TAX REGISTRATION REASON CODE"];
    
    [ViewAppearance setGlowToLabel:self.lblCorNumber];
    self.lblCorNumber.text = [Translator languageSelectedStringForKey:@"CORRESPONDENT ACCOUNT"];
    
    [ViewAppearance setGlowToLabel:self.lblComment];
    self.lblComment.text = [Translator languageSelectedStringForKey:@"COMMENTS"];

    
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

-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: [Translator languageSelectedStringForKey:@"CONFIRM DELETION OF BANK ACCOUNT"]
                          
                                                   message: nil
                                                  delegate: self
                                         cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"]
                                         otherButtonTitles:[Translator languageSelectedStringForKey:@"Delete"],nil];
        
        
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {

    }
    else
    {
        if ([DBadapter DeleteDocument:bankAccount])
                    [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = bankAccount.accountNumber;
    
    [super showMessageBoxWithTitle:[Translator languageSelectedStringForKey:@"Bank account was copied"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendBtnTapped
{
    NSMutableString *message = [[NSMutableString alloc] init];

    [message appendString:[Translator languageSelectedStringForKey:@"Bank: "]];
    [message appendString:bankAccount.bank];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Account: "]];
    [message appendString:bankAccount.accountNumber];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Currency: "]];
    [message appendString:[CurrencyType getCurrencyByType:bankAccount.curType].name];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"BIK: "]];
    [message appendString:bankAccount.bik];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Taxpayer id: "]];
    [message appendString:bankAccount.inn];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Correspondent acc.: "]];
    [message appendString:bankAccount.kpp];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Tax reg. reason code: "]];
    [message appendString:bankAccount.corNumber];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Comments: "]];
    [message appendString:bankAccount.comments];
    
    [super sendMessage:message];
}

@end
