//
//  FrameVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 07.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CollectionView.h"

#import "ViewAppearance.h"
#import "KSEnhancedKeyboard.h"
#import "TextField.h"
#import "Picker.h"

#import "CollectionRV.h"
#import "PhotoCell.h"
#import "GGFullScreenImageViewController.h"
#import "DocumentLib.h"
#import "M13ProgressViewPie.h"
#import "RNBlurModalView.h"

@interface FrameVC : UIViewController<UITextFieldDelegate, KSEnhancedKeyboardDelegate, UITextViewDelegate, PickerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, PhotoCellDelegate, AddImageDelegate>
{
    UIToolbar *toolbar;
    UITextField *activeField;
    BOOL firstOpenEditVC;
    
@private BOOL showPrevious; //показывать кнопку "предыдущий" в клаивиатуре
@private BOOL showNext; //показывать кнопку "следующий" в клавиатуре
@private BOOL donePressed;
    
}
@property (nonatomic, retain) IBOutlet M13ProgressViewPie *progressView;

@property (strong) Document *selectedDocument;

@property (nonatomic, weak) IBOutlet CollectionView *colView;

@property (nonatomic, strong) NSMutableArray *photoList;

@property (strong, nonatomic) KSEnhancedKeyboard *enhancedKeyboard;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (void)viewDidLoad: (NSString*)title;
-(void)backBtnTapped;

@property (nonatomic, retain) IBOutlet UIButton *deleteBtn;

- (IBAction) deleteDoc: (id)sender;
- (void)showMainVC;

-(void)showInTextField:(UITextField*)textField selectedPickerObject:(PickerObject *)selectedPickerObject; //показывает выбранную картинку из пикера в текстовом поле
@end