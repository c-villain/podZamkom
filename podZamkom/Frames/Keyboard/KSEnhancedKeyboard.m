//
//  KSEnhancedKeyboard.m
//  Pod zamkom
//
//  Created by Alexander Kraev on 03.09.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "KSEnhancedKeyboard.h"

@implementation KSEnhancedKeyboard

- (UIToolbar *)getToolbarWithPrevEnabled:(BOOL)prevEnabled NextEnabled:(BOOL)nextEnabled DoneEnabled:(BOOL)doneEnabled
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
    
    UISegmentedControl *leftItems = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
    leftItems.momentary = YES;
    
    [leftItems setEnabled:prevEnabled forSegmentAtIndex:0];
    [leftItems setEnabled:nextEnabled forSegmentAtIndex:1];
    leftItems.momentary = YES; // do not preserve button's state
    [leftItems addTarget:self action:@selector(nextPrevHandlerDidChange:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *nextPrevControl = [[UIBarButtonItem alloc] initWithCustomView:leftItems];
    [toolbarItems addObject:nextPrevControl];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [toolbarItems addObject:flexSpace];
    if (doneEnabled)
    {
        UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneDidClick:)];
        [toolbarItems addObject:doneButton];
    }
    toolbar.items = toolbarItems;
    
    return toolbar;
}

- (void)nextPrevHandlerDidChange:(id)sender
{
    switch ([(UISegmentedControl *)sender selectedSegmentIndex])
    {
        case 0:
            [self.delegate previousDidTouchDown];
            break;
        case 1:
            [self.delegate nextDidTouchDown];
            break;
        default:
            break;
    }
}

- (void)doneDidClick:(id)sender
{
    [self.delegate doneDidTouchDown];
}

-(void)undoClick:(id)sender
{
    [self.delegate previousDidTouchDown];
}

-(void)redoClick:(id)sender
{
    [self.delegate nextDidTouchDown];
}

@end
