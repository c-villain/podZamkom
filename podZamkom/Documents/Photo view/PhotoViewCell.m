//
//  PhotoViewCell.m
//  podZamkom
//
//  Created by Alexander Kraev on 17.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell

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


-(void)initWithImage:(UIImage*) image;
{
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    ////
    
    UIImageView *photoView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)] initWithImage:image];
    self.photo = photoView;
    ////
    [self.contentView addSubview:imageView];
}

@end
