//
//  PhotoCell.m
//  podZamkom
//
//  Created by Alexander Kraev on 14.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(0,self.frame.size.height - self.frame.size.height/5, self.frame.size.width, self.frame.size.height/5);
        [self.deleteBtn addTarget:self action:@selector(deleteBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:48.0f/255.0f blue:71.0f/255.0f alpha:1.0f];;
        
        //рисуем "крестик" на кнопке удалить рисунок:
        UIImage *closeImage = [UIImage imageNamed: @"title_bar_icon_close.png"];
        UIImageView *closeView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 20,0, 40, 40)] initWithImage:closeImage];
        [self.deleteBtn addSubview:closeView];
        
        //добавляем кнопку "удалить" в ячейку:
        [self.contentView addSubview:self.deleteBtn];
        
    }
    return self;
}

-(void)initWithImage:(UIImage*) image;
{
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height* 4/5)] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    [self.contentView addSubview:imageView];
}

-(void)deleteBtnTapped
{
    if ([_photoCellDelegate respondsToSelector:@selector(DeleteCell:)])
    {
        [_photoCellDelegate DeleteCell:self.index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
