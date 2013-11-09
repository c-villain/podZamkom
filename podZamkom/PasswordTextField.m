//
//  PasswordTextField.m
//  podZamkom
//
//  Created by Alexander Kraev on 07.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PasswordTextField.h"

@implementation PasswordTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) drawPlaceholderInRect:(CGRect)rect
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: self.font};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake(rect.size.width/2 -boundingRect.size.width/2 , (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
}

@end
