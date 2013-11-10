//
//  CardType.m
//  Под замком
//
//  Created by Alexander Kraev on 30.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardType.h"

@implementation CardType

@synthesize cardType;


+(NSArray *)initCardTypeArray
{
    CardType *type1 = [CardType new];
    type1.name = @"VISA";
    type1.image = @"visa.png";
    type1.enumObject = Visa;
    
    CardType *type2 = [CardType new];
    type2.name = @"VISA Electron";
    type2.image = @"visaelectron.png";
    type2.enumObject = VisaElectron;
    
    CardType *type3 = [CardType new];
    type3.name = @"Mastercard";
    type3.image = @"mastercard.png";
    type3.enumObject = Mastercard;
    
    CardType *type4 = [CardType new];
    type4.name = @"Maestro";
    type4.image = @"maestro.png";
    type4.enumObject = Maestro;
    
    CardType *type5 = [CardType new];
    type5.name = @"Cirrus";
    type5.image = @"cirrus.png";
    type5.enumObject = Cirrus;
    
    CardType *type6 = [CardType new];
    type6.name = @"Discover";
    type6.image = @"discover.png";
    type6.enumObject = Discover;
    
    CardType *type7 = [CardType new];
    type7.name = @"JCB";
    type7.image = @"jcb.png";
    type7.enumObject = JCB;
    
    CardType *type8 = [CardType new];
    type8.name = @"Carte Blanche";
    type8.image = @"cb.png";
    type8.enumObject = CarteBlanche;
    
    CardType *type9 = [CardType new];
    type9.name = @"American Express";
    type9.image = @"aex.png";
    type9.enumObject = AmericanExpress;
    
    CardType *type10 = [CardType new];
    type10.name = @"UnionPay";
    type10.image = @"unionPay.png";
    type10.enumObject = UnionPay;
    
    CardType *type11 = [CardType new];
    type11.name = @"Laser";
    type11.image = @"laser.png";
    type11.enumObject = Laser;
    
    CardType *type12 = [CardType new];
    type12.name = @"Diners Club";
    type12.image = @"dinersclub.png";
    type12.enumObject = DinersClub;
    
    NSArray * array = [NSArray arrayWithObjects:type1, type2, type3, type4, type5, type6, type7, type8, type9, type10, type11, type12, nil];
    return array;
}

@end
