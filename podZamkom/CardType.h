//
//  CardType.h
//  Под замком
//
//  Created by Alexander Kraev on 30.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface CardType : NSObject

@property (nonatomic, strong) NSString *image; 
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CardTypeEnum enumObject;

+(NSArray *)initCardTypeArray;

@end
