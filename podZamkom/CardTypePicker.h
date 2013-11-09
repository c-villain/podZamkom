//
//  CardTypePicker.h
//  Pod zamkom
//
//  Created by Alexander Kraev on 05.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardType.h"


@protocol CardTypePickerDelegate

-(void)cardTypeSelected:(CardType *) type;

@end

@interface CardTypePicker : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, strong) id <CardTypePickerDelegate> pickerDelegate;

+(CardTypePicker*)createPickerWithData:(NSArray*)cardTypes andPickerDelegate:(id)pickDelegate;
-(void)initPickerWithData:(NSArray*)cardTypes andPickerDelegate:(id)pickDelegate;

@end
