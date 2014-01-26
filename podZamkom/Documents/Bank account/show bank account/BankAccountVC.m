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
        document = bankAccountDoc;
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
    [super viewDidLoad: ((BankAccount *)document).bank];
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

    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE BANK ACCOUNT"] forState:UIControlStateNormal];
    [self.sendBtn setTitle:[Translator languageSelectedStringForKey:@"SEND BANK ACCOUNT"] forState:UIControlStateNormal];
    //забиваю значения:
    self.lblBank.text = ((BankAccount *)document).bank;
    self.accountNumberField.text = [self getStringWithNumber:((BankAccount *)document).accountNumber andCurrency:((BankAccount *)document).curType];
    self.bikField.text = ((BankAccount *)document).bik;
    self.innField.text = ((BankAccount *)document).inn;
    self.kppField.text = ((BankAccount *)document).kpp;
    self.corNumberField.text = ((BankAccount *)document).corNumber;
    self.bankAccountComment.text = ((BankAccount *)document).comments;
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
        if ([DBadapter DeleteDocument:(BankAccount *)document])
                    [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = ((BankAccount *)document).accountNumber;
    
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
    [message appendString:((BankAccount *)document).bank];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Account: "]];
    [message appendString:((BankAccount *)document).accountNumber];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Currency: "]];
    [message appendString:[CurrencyType getCurrencyByType:((BankAccount *)document).curType].name];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"BIK: "]];
    [message appendString:((BankAccount *)document).bik];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Taxpayer id: "]];
    [message appendString:((BankAccount *)document).inn];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Correspondent acc.: "]];
    [message appendString:((BankAccount *)document).kpp];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Tax reg. reason code: "]];
    [message appendString:((BankAccount *)document).corNumber];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Comments: "]];
    [message appendString:((BankAccount *)document).comments];
    
    [super sendMessage:message];
}

@end
