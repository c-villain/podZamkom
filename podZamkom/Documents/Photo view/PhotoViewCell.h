//
//  PhotoViewCell.h
//  podZamkom
//
//  Created by Alexander Kraev on 17.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewCell : UICollectionViewCell

@property (nonatomic, strong, readwrite) IBOutlet UIImageView *photo;
-(void)initWithImage:(UIImage*) image;

@end
