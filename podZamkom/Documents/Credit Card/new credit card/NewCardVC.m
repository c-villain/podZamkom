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
    NSString* title = @"НОВАЯ КАРТА";
    //забиваем маску для нужных текстовых полей:
    [(TextField *)self.numberField initWithMask:@"9999 9999 9999 9999"];
    [(TextField *)self.validThruDate initWithMask:@"99/99"];
    [(TextField *)self.cvcField initWithMask:@"9999"];
    
    //инициализируем пикеры (цвета и типа):
    ((TextField *)self.typeField).picker = [Picker createPickerWithData:[CardType initCardTypeArray] andPickerDelegate:self];
    ((TextField *)self.colorField).picker = [Picker createPickerWithData:[CardColor initCardColorArray] andPickerDelegate:self];
    
    //по умолч. ставим везде пустые текстовые поля:
    self.bankField.text = @"";
    self.numberField.text = @"";
    self.typeField.text = @"";
    self.validThruDate.text = @"";
    self.cardHolderField.text = @"";
    self.cvcField.text = @"";
    self.pinField.text = @"";
    self.colorField.text = @"";
    self.commentField.text = @"";
    
    [self.bankField becomeFirstResponder];
    
    //если же мы находимся в режиме редактирования, то заполняем все поля:
    if (self.selectedCreditCard != nil)
    {
        title = self.selectedCreditCard.bank;
        self.bankField.text = self.selectedCreditCard.bank;
        self.numberField.text = self.selectedCreditCard.number;
        [super showInTextField:self.typeField selectedPickerObject:[CardType initCardTypeArray][self.selectedCreditCard.type]];
        self.validThruDate.text = self.selectedCreditCard.validThru;
        self.cardHolderField.text = self.selectedCreditCard.holder;
        self.cvcField.text = self.selectedCreditCard.cvc;
        self.pinField.text = self.selectedCreditCard.pin;
        [super showInTextField:self.colorField selectedPickerObject:[CardColor initCardColorArray][self.selectedCreditCard.color]];
        self.commentField.text = self.selectedCreditCard.comments;
    }
    [super viewDidLoad:title];
}

-(void)saveBtnTapped
{
    CreditCard *card = [CreditCard new];
    card.idDoc = self.selectedCreditCard.idDoc;
    card.docType = CardDoc;
    
    card.bank = @"Банк";
    if (![[self.bankField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
        card.bank = self.bankField.text;
    
    
    card.holder = self.cardHolderField.text;
    card.type = ( (Picker *) ((TextField *)self.typeField).picker).selectedIndex;
    card.number = self.numberField.text;
    card.validThru = self.validThruDate.text;
    card.cvc = self.cvcField.text;
    card.pin = self.pinField.text;
    card.color = (CardColorEnum)( (Picker *) ((TextField *)self.colorField).picker).selectedIndex;
    card.comments = self.commentField.text;

    if ([DBadapter DBSave:card])
        [super showMainVC];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
