//
//  CardColor.m
//  podZamkom
//
//  Created by Alexander Kraev on 09.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardColor.h"

@implementation CardColor

@synthesize cardColor;


+(NSArray *)initCardColorArray
{
    CardColor *color1 = [CardColor new];
    color1.name = @"Grey";
    color1.image = @"card_grey.png";
    color1.cardColor = grey;
    
    CardColor *color2 = [CardColor new];
    color2.name = @"Red";
    color2.image = @"card_red.png";
    color2.cardColor = red;
    
    CardColor *color3 = [CardColor new];
    color3.name = @"Blue";
    color3.image = @"card_blue.png";
    color3.cardColor = blue;
    
    CardColor *color4 = [CardColor new];
    color4.name = @"Gold";
    color4.image = @"card_orange.png";
    color4.cardColor = gold;
    
    CardColor *color5 = [CardColor new];
    color5.name = @"Green";
    color5.image = @"card_green.png";
    color5.cardColor = green;
    
    CardColor *color6 = [CardColor new];
    color6.name = @"Pink";
    color6.image = @"card_pink.png";
    color6.cardColor = pink;
    
    CardColor *color7 = [CardColor new];
    color7.name = @"Purple";
    color7.image = @"card_purple.png";
    color7.cardColor = purple;
    
    NSArray * array = [NSArray arrayWithObjects:color1, color2, color3, color4, color5, color6, color7,  nil];
    return array;
}

+(CardColor *)getCardColorByType: (CardColorEnum) color
{
    NSArray *array = [CardColor initCardColorArray];
    int counter=[array count];
    CardColor* cardColor = [CardColor new];
    for(int i=0;i<counter;i++)
    {
        CardColor *currentColor = [array objectAtIndex:i];
        if (currentColor.cardColor == color)
            cardColor = currentColor;
    }
    return cardColor;
}

@end



