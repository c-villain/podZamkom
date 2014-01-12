//
//  CollectionView.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteCV.h"

@interface CollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet NoteCV *noteCV;

@end
