//
//  NewCardVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewCardVC.h"

@implementation NewCardVC

- (void)viewDidLoad
{
    [super viewDidLoad:@"НОВАЯ КАРТА"];
    
    self.bankField.text = @"";
    self.numberField.text = @"";
    self.typeField.text = @"";
    self.validThruDate.text = @"";
    self.cardHolderField.text = @"";
    self.cvcField.text = @"";
    self.pinField.text = @"";
    self.colorField.text = @"";
    self.commentField.text = @"";

    if (self.selectedCreditCard != nil)
    {
        self.bankField.text = self.selectedCreditCard.bank;
        self.numberField.text = self.selectedCreditCard.number;
        self.typeField.text = self.selectedCreditCard.type.name;
        self.validThruDate.text = self.selectedCreditCard.validThru;
        self.cardHolderField.text = self.selectedCreditCard.holder;
        self.cvcField.text = self.selectedCreditCard.cvc;
        self.pinField.text = self.selectedCreditCard.pin;
//        TODO!
        self.colorField.text = @"";//[self.selectedCreditCard.color ];
        self.commentField.text = self.selectedCreditCard.comments;
    }
    [(TextField *)self.numberField initWithMask:@"9999 9999 9999 9999"];
    [(TextField *)self.validThruDate initWithMask:@"99/99"];
    [(TextField *)self.cvcField initWithMask:@"9999"];
//    cardTypes = [CardType initCardTypeArray];
    ((TextField *)self.typeField).picker = [CardTypePicker createPickerWithData:[CardType initCardTypeArray] andPickerDelegate:self];
    [self.bankField becomeFirstResponder];
}

-(void)saveBtnTapped
{
    //    TODO!
    NSLog(@"SAVE!");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
