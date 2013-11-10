//
//  FrameVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 07.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAppearance.h"
#import "KSEnhancedKeyboard.h"
#import "TextField.h"
#import "Picker.h"

@interface FrameVC : UIViewController<UITextFieldDelegate, KSEnhancedKeyboardDelegate, UITextViewDelegate, PickerDelegate>
{
    UIToolbar *toolbar;
    UITextField *activeField;
@private BOOL showPrevious; //показывать кнопку "предыдущий" в клаивиатуре
@private BOOL showNext; //показывать кнопку "следующий" в клавиатуре
@private BOOL donePressed;
}

@property (strong, nonatomic) KSEnhancedKeyboard *enhancedKeyboard;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (void)viewDidLoad: (NSString*)title;
-(void)backBtnTapped;
- (void)showMainVC;

@end