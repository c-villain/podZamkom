//
//  Picker.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 05.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerObject.h"


@protocol PickerDelegate

-(void)showSelectedPickerObjectInActiveField:(PickerObject *)selectedPickerObject;

@end

@interface Picker : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, strong) id <PickerDelegate> pickerDelegate;

+(Picker*)createPickerWithData:(NSArray*)dataArray andPickerDelegate:(id)pickDelegate;
-(void)initPickerWithData:(NSArray*)dataArray andPickerDelegate:(id)pickDelegate;

@end
