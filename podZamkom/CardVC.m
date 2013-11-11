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
    
    self.cardType.image = [UIImage imageNamed:[self cardTypeImageName:card.type]];
    self.cardColor.image = [UIImage imageNamed:[self cardColorImageName:card.color]];
}

-(NSString *)cardTypeImageName:(CardTypeEnum)type
{
    switch (type) {
        case Visa:
        default:
            return @"visa.png";
            break;
        case VisaElectron:
            return @"visaelectron.png";
            break;
        case Mastercard:
            return @"mastercard";
            break;
        case Maestro:
            return @"maestro.png";
            break;
        case Cirrus:
            return @"cirrus.png";
            break;
        case Discover:
            return @"discover.png";
            break;
        case JCB:
            return @"jcb.png";
            break;
        case CarteBlanche:
            return @"cb.png";
            break;
        case AmericanExpress:
            return @"aex.png";
            break;
        case UnionPay:
            return @"unionPay.png";
            break;
        case Laser:
            return @"laser.png";
            break;
        case DinersClub:
            return @"dinersclub.png";
            break;
    }
}

-(NSString *)cardColorImageName:(CardColorEnum)color
{
    switch (color) {
        case grey:
            return @"card_grey.png";
            break;
        case red:
            return @"card_red.png";
            break;
        case blue:
            return @"card_blue.png";
            break;
        case gold:
            return @"card_orange.png";
            break;
        case green:
            return @"card_green.png";
            break;
        case pink:
            return @"card_pink.png";
            break;
        case purple:
            return @"card_purple.png";
            break;
        default:
            break;
    }
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewCardVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newCard"];
    myController.selectedCreditCard = card;
    [self.navigationController pushViewController:myController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
