//
//  TextField.h
//  Под замком
//
//  Created by Alexander Kraev on 27.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSEnhancedKeyboard.h"

@interface TextField : UITextField

//The property that can be used to set mask variable
@property (nonatomic, retain) NSString* mask;
@property (nonatomic, retain) UIPickerView *picker;

//A custom initilizer where the user can set the input mask
- (void)initWithMask:(NSString*)aMask;

@end
