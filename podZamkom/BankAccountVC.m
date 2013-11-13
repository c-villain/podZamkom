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
    self.accountNumberField.text = [bankAccount.accountNumber stringByAppendingString:[self convertCurTypeToString:bankAccount.curType]];
    self.bikField.text = bankAccount.bik;
    self.innField.text = bankAccount.inn;
    self.kppField.text = bankAccount.kpp;
    self.corNumberField.text = bankAccount.corNumber;
    self.bankAccountComment.text = bankAccount.comments;
}

- (NSString *) convertCurTypeToString:(CurrencyTypeEnum) type
{
    NSString *result = @"";
    
    switch(type) {
        case BYR:
            result = @"(BYR)";
            break;
        case CNY:
            result = @"(CNY)";
            break;
        case CHF:
            result = @"(CHF)";
            break;
        case CYP:
            result = @"(CYP)";
            break;
        case EUR:
            result = @"(EUR)";
            break;
        case GBP:
            result = @"(GBP)";
            break;
        case HKD:
            result = @"(HKD)";
            break;
        case ILS:
            result = @"(ILS)";
            break;
        case JPY:
            result = @"(JPY)";
            break;
        case RUR:
            result = @"(RUR)";
            break;
        case SGD:
            result = @"(SGD)";
            break;
        case UAH:
            result = @"(UAH)";
            break;
        case USD:
        default:
            result = @"(USD)";
            break;
    }
    
    return result;
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
