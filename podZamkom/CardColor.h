//
//  CardColor.h
//  podZamkom
//
//  Created by Alexander Kraev on 09.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    grey = 0,
    red = 1,
    blue = 2,
    gold = 3,
    green,
    pink,
    purple
} CardColorEnum;

@interface CardColor : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CardColorEnum enumObject;

+(NSArray *)initCardColorArray;

@end
