//
//  CollectionRV.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddImageDelegate<NSObject>
@optional
//методы для сигнализирования главному окну, что кнопка добавления фото была нажата
- (void)AddNewPhotoPressed:(UIImage *)selectedPhotoData;
- (void)SearchStop;
@end

@interface CollectionRV : UICollectionReusableView<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak) id<AddImageDelegate> addImageDelegate;

@property (strong, nonatomic) IBOutlet UILabel *lblPhoto;
@property (nonatomic, retain) IBOutlet UIButton *addNewPhoto;


- (IBAction) addPhotoPressed: (id)sender;

@end
