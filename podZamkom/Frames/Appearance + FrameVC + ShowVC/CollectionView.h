//
//  CollectionView.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CollectionRV.h"
#import "PhotoCell.h"
#import "GGFullScreenImageViewController.h"
#import "DocCRVs.h"

@interface CollectionView : UICollectionView

@property (nonatomic, weak) IBOutlet NoteCRV *collectionNoteCV;
@property (nonatomic, weak) IBOutlet BankAccountCRV *collectionBankAccountCV;
@property (nonatomic, weak) IBOutlet CardCRV  *collectionCardCV;
@property (nonatomic, weak) IBOutlet PassportCRV  *collectionPassportCV;
@property (nonatomic, weak) IBOutlet LoginCRV  *collectionLoginCV;

@end
