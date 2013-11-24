//
//  Picker.m
//  Pod zamkom
//
//  Created by Alexander Kraev on 05.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Picker.h"

@implementation Picker

@synthesize data;
@synthesize selectedIndex;
@synthesize pickerDelegate;

-(id)init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

+(Picker*)createPickerWithData:(NSArray*)dataArray andPickerDelegate:(id)pickDelegate
{
    Picker *picker = [[Picker alloc] init];
    picker.data = dataArray;
    [picker setShowsSelectionIndicator:YES];
    picker.pickerDelegate = pickDelegate;
    return picker;
}

-(void)initPickerWithData:(NSArray*)dataArray andPickerDelegate:(id)pickDelegate
{
    self.data = dataArray;
    [self setShowsSelectionIndicator:YES];
    self.pickerDelegate = pickDelegate;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return data.count;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    PickerObject *object = [data objectAtIndex:row];
    [self.pickerDelegate showSelectedPickerObjectInActiveField:object];
    selectedIndex = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    PickerObject *object = [data objectAtIndex:row];
    UIImage *img = [UIImage imageNamed:object.image];
    UIImageView *temp = [[UIImageView alloc] initWithImage:img];
    temp.frame = CGRectMake(-95, 0, 70, 42);
    
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 200, 42)];
    channelLabel.text = object.name;
    channelLabel.textAlignment = NSTextAlignmentLeft;
    channelLabel.backgroundColor = [UIColor clearColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 42)];
    [tmpView insertSubview:temp atIndex:0];
    [tmpView insertSubview:channelLabel atIndex:1];
    
    return tmpView;
}

@end
