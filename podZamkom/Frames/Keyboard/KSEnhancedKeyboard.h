//
//  KSEnhancedKeyboard.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 03.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KSEnhancedKeyboardDelegate

- (void)nextDidTouchDown;
- (void)previousDidTouchDown;
- (void)doneDidTouchDown;

@end

@interface KSEnhancedKeyboard : NSObject

@property (nonatomic, strong) id <KSEnhancedKeyboardDelegate> delegate;

- (UIToolbar *)getToolbarWithPrevEnabled:(BOOL)prevEnabled NextEnabled:(BOOL)nextEnabled DoneEnabled:(BOOL)doneEnabled;

@end
