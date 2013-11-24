//
//  ViewAppearance.m
//  podZamkom
//
//  Created by Alexander Kraev on 20.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ViewAppearance.h"

@implementation ViewAppearance

+(UIView *)initViewWithGlowingTitle:(NSString *) titleString
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    navBarLabel.text = titleString;
    [navBarLabel setTextAlignment:NSTextAlignmentCenter];
    navBarLabel.font = [UIFont fontWithName:@"Menlo-Regular" size:16.0f];
    navBarLabel.textColor = [UIColor whiteColor];
    
    UIColor *color = [UIColor colorWithRed:52.0f/255.0f green:144.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    navBarLabel.layer.shadowColor = [color CGColor];
    navBarLabel.layer.shadowRadius = 4.0f;
    navBarLabel.layer.shadowOpacity = 0.77f;
    navBarLabel.layer.shadowOffset = CGSizeZero;
    navBarLabel.layer.masksToBounds = NO;
    
    [titleView addSubview:navBarLabel];
    return titleView;
}

+(UIImageView *)initGlowingBoarderForNavBar
{
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 12)];
    iv.image= [UIImage imageNamed:@"line_under_title_bar.png"];
    return iv;
}

+(UIButton *)initCustomButtonWithImage: (NSString *) imageName
{
    UIImage *background = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:background forState:UIControlStateNormal];
    button.frame = CGRectMake(0,0,40,40);
    return button;
}

+(void)setGlowToLabel:(UILabel *)label
{
    UIColor *color = [UIColor colorWithRed:52.0f/255.0f green:144.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    label.layer.shadowColor = [color CGColor];
    label.layer.shadowRadius = 4.3f;
    label.layer.shadowOpacity = 3.1f;
    label.layer.shadowOffset = CGSizeZero;
    label.layer.masksToBounds = NO;
}

@end
