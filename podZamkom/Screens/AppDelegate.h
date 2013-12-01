//
//  AppDelegate.h
//  podZamkom
//
//  Created by Alexander Kraev on 01.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordVC.h"
#import "MainTableVC.h"
#import "Security.h"
#import "SWRevealViewController.h"
#import "LeftMenuVC.h"
#import "DBlib.h"
#import "Settings.h"

@class SWRevealViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, PasswordVCDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
