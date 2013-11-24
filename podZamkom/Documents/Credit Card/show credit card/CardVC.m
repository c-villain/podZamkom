//
//  CardVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardVC.h"

@interface CardVC ()

@end

@implementation CardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Card:(CreditCard*) cardDoc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        card = cardDoc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad: card.bank];
    // Do any additional setup after loading the view from its nib.
    [ViewAppearance setGlowToLabel:self.lblCvc];
    [ViewAppearance setGlowToLabel:self.lblPin];
    [ViewAppearance setGlowToLabel:self.lblComment];
    
    //забиваю значения:
    self.cardBank.text = card.bank;
    self.cardNumber.text = card.number;
    self.cardValidThru.text = card.validThru;
    self.cardHolder.text = card.holder;
    self.cardCvc.text = card.cvc;
    self.cardPin.text = card.pin;
    self.cardComment.text = card.comments;
    
    self.cardType.image = [UIImage imageNamed:[CardType getCurrentCardByType:card.type].image];
    self.cardColor.image = [UIImage imageNamed:[CardColor getCardColorByType:card.color].image];
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewCardVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newCard"];
    myController.selectedCreditCard = card;
    [self.navigationController pushViewController:myController animated:YES];
}

-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"ПОДТВЕРДИТЕ УДАЛЕНИЕ"
                                                   message: @"Кредитная карта"
                                                  delegate: self
                                         cancelButtonTitle:@"Отмена"
                                         otherButtonTitles:@"Удалить",nil];
    
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        if ([DBadapter DeleteDocument:card])
            [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.cardNumber.text;
    
    [super showMessageBoxWithTitle:@"Номер карты скопирован"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
