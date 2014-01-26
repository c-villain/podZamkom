//
//  PhotoCell.h
//  podZamkom
//
//  Created by Alexander Kraev on 14.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoCellDelegate<NSObject>

@optional
- (void)DeleteCell:(NSInteger)index;
@end

@interface PhotoCell : UICollectionViewCell

@property (weak) id<PhotoCellDelegate> photoCellDelegate;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,assign) NSInteger index;
-(void)initWithImage:(UIImage*) image;

-(void)deleteBtnTapped;
@end
