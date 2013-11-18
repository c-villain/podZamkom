//
//  MainTableVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 11.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ViewAppearance.h"

#import "DBlib.h"
#import "DocumentLib.h"
#import "DocViews.h"
#import "LeftMenuVC.h"

@interface MainTableVC : UITableViewController <DocSortingDelegate>
{
    NSArray *documents;
    DBadapter *dbAdapter;
}

@end