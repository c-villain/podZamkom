//
//  PhotoVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 18.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGFullScreenImageViewController.h"
#import "DocumentLib.h"
#import "PhotoViewCell.h"
#import "ViewAppearance.h"


@interface PhotoVC : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) IBOutlet UICollectionView *colView;
@property (nonatomic, strong) Document *document;


@end
