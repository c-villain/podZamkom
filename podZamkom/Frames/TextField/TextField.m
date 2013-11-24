//
//  TextField.m
//  Под замком
//
//  Created by Alexander Kraev on 27.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "TextField.h"

@implementation TextField

@synthesize mask;


- (void)initWithMask:(NSString*)aMask
{
    self.mask = aMask;
}

- (void)initWithPicker:(UIPickerView*)aPicker
{
    self.picker = aPicker;
}

-(id)init
{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset([super editingRectForBounds:bounds], 0.0f, 2.5f);
}

- (void) drawPlaceholderInRect:(CGRect)rect {
//    center aligment
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    UIColor *fontColor = [UIColor colorWithRed:114.0/255.0 green:128.0/255.0 blue:144.0/255.0 alpha:1.0];
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:self.font,
                                                         NSForegroundColorAttributeName:fontColor,
                                                         NSParagraphStyleAttributeName: paragraphStyle}];
}

@end
