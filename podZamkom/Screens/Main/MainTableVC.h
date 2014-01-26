//
//  MainTableVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 11.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealVC.h"
#import "ViewAppearance.h"

#import "DBlib.h"
#import "DocumentLib.h"
#import "DocViews.h"
#import "LeftMenuVC.h"
#import "Cell.h"

@interface MainTableVC : UITableViewController <DocSortingDelegate, UISearchBarDelegate, SearchDocDelegate>
{
    NSMutableArray *documents; //документы для выбора
    NSArray *cashDocs; //кэш для документов: здесь всегда хранятся все документы
}

@end