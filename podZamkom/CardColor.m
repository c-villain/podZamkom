//
//  CardColor.m
//  podZamkom
//
//  Created by Alexander Kraev on 09.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardColor.h"

@implementation CardColor


@synthesize image;
@synthesize name;
@synthesize enumObject;


+(NSArray *)initCardColorArray
{
    CardColor *color1 = [CardColor new];
    color1.name = @"Grey";
    color1.image = @"grey.png";
    color1.enumObject = grey;
    
    CardColor *color2 = [CardColor new];
    color2.name = @"Red";
    color2.image = @"red.png";
    color2.enumObject = red;
    
    CardColor *color3 = [CardColor new];
    color3.name = @"Blue";
    color3.image = @"blue.png";
    color3.enumObject = blue;
    
    CardColor *color4 = [CardColor new];
    color4.name = @"Gold";
    color4.image = @"gold.png";
    color4.enumObject = gold;
    
    CardColor *color5 = [CardColor new];
    color5.name = @"Green";
    color5.image = @"green.png";
    color5.enumObject = green;
    
    CardColor *color6 = [CardColor new];
    color6.name = @"Pink";
    color6.image = @"pink.png";
    color6.enumObject = pink;
    
    CardColor *color7 = [CardColor new];
    color7.name = @"Purple";
    color7.image = @"purple.png";
    color7.enumObject = purple;
    
    NSArray * array = [NSArray arrayWithObjects:color1, color2, color3, color4, color5, color6, color7,  nil];
    return array;
}

@end



