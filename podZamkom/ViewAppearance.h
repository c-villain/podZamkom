//
//  ViewAppearance.h
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewAppearance : NSObject


+(UIView *)initViewWithGlowingTitle:(NSString *) titleString;
+(UIImageView *)initGlowingBoarderForNavBar;
+(UIButton *)initCustomButtonWithImage: (NSString *) imageName;
+(void)setGlowToLabel:(UILabel *)label;

@end
