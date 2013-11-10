//
//  CardType.h
//  Под замком
//
//  Created by Alexander Kraev on 30.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerObject.h"

typedef enum {
    Visa = 0,
    VisaElectron = 1,
    Mastercard = 2,
    Maestro = 3,
    Cirrus,
    Discover,
    JCB,
    CarteBlanche,
    AmericanExpress,
    UnionPay,
    Laser,
    DinersClub
} CardTypeEnum;

@interface CardType : PickerObject

@property (nonatomic, assign) CardTypeEnum cardType;

+(NSArray *)initCardTypeArray;

@end
