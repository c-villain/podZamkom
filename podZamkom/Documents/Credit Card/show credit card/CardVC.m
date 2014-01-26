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
        document = cardDoc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad: ((CreditCard *)document).bank];
    // Do any additional setup after loading the view from its nib.
    [ViewAppearance setGlowToLabel:self.lblCvc];
    [ViewAppearance setGlowToLabel:self.lblPin];
    [ViewAppearance setGlowToLabel:self.lblComment];
    self.lblComment.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE CARD"] forState:UIControlStateNormal];
    //забиваю значения:
    self.cardBank.text = ((CreditCard *)document).bank;
    self.cardNumber.text = ((CreditCard *)document).number;
    self.cardValidThru.text = ((CreditCard *)document).validThru;
    self.cardHolder.text = ((CreditCard *)document).holder;
    self.cardCvc.text = ((CreditCard *)document).cvc;
    self.cardPin.text = ((CreditCard *)document).pin;
    self.cardComment.text = ((CreditCard *)document).comments;
    
    self.cardType.image = [UIImage imageNamed:[CardType getCurrentCardByType:((CreditCard *)document).type].image];
    self.cardColor.image = [UIImage imageNamed:[CardColor getCardColorByType:((CreditCard *)document).color].image];
}


-(void)deleteBtnTapped
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: [Translator languageSelectedStringForKey:@"CONFIRM DELETION OF CARD"]

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
        if ([DBadapter DeleteDocument:(CreditCard *)document])
            [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.cardNumber.text;
    
    [super showMessageBoxWithTitle:[Translator languageSelectedStringForKey:@"Card number was copied"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
