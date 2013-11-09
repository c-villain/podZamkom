//
//  CardTypePicker.m
//  Pod zamkom
//
//  Created by Alexander Kraev on 05.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardTypePicker.h"

@implementation CardTypePicker

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

+(CardTypePicker*)createPickerWithData:(NSArray*)cardTypes andPickerDelegate:(id)pickDelegate
{
    CardTypePicker *cardTypePicker = [[CardTypePicker alloc] init];
    cardTypePicker.data = cardTypes;
    [cardTypePicker setShowsSelectionIndicator:YES];
    cardTypePicker.pickerDelegate = pickDelegate;
    return cardTypePicker;
}

-(void)initPickerWithData:(NSArray*)cardTypes andPickerDelegate:(id)pickDelegate
{
    self.data = cardTypes;
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
    CardType *type = [data objectAtIndex:row];
    [self.pickerDelegate cardTypeSelected:type];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CardType *type = [data objectAtIndex:row];
    UIImage *img = [UIImage imageNamed:type.image];
    UIImageView *temp = [[UIImageView alloc] initWithImage:img];
    temp.frame = CGRectMake(-95, 0, 70, 42);
    
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 200, 42)];
    channelLabel.text = type.name;
    channelLabel.textAlignment = NSTextAlignmentLeft;
    channelLabel.backgroundColor = [UIColor clearColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 42)];
    [tmpView insertSubview:temp atIndex:0];
    [tmpView insertSubview:channelLabel atIndex:1];
    
    return tmpView;
}

@end
