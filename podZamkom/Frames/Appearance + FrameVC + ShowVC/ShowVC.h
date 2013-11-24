//
//  ShowVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAppearance.h"
#import "DocumentLib.h"
#import "NewDocViews.h"
#import "RNBlurModalView.h"

@interface ShowVC : UIViewController

- (void)viewDidLoad: (NSString*)title;

@property (nonatomic, retain) IBOutlet UIButton *deleteBtn;

- (IBAction) deleteDoc: (id)sender;

@property (nonatomic, nonatomic) IBOutlet UIButton *btnCopy;

- (IBAction) copyDoc: (id)sender;

- (void)showMainVC;
-(void)showMessageBoxWithTitle:(NSString*)title;
@end
