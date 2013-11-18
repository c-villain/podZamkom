//
//  LeftMenuVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 15.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "LeftMenuVC.h"

@interface LeftMenuVC ()

@end

@implementation LeftMenuVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Remove table cell separator
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
//    self.navigationController.navigationBarHidden = YES;
    
    //в зависимости от модели айфона включаем или выключаем скроллинг левого меню:
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (screenSize.height > 480.0f)
        {
            /*Do iPhone 5 stuff here.*/
            self.tableView.scrollEnabled = NO;
        } else
        {
            /*Do iPhone Classic stuff here.*/
             self.tableView.scrollEnabled = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;
    return YES;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.item)
    {
        case 0:
        default:
//            self.docType =
            break;
        case 1:
            self.docType = NoteDoc;
            break;
        case 2:
            self.docType = CardDoc;
            break;
        case 3:
            self.docType = PassportDoc;
            break;
        case 4:
            self.docType = BankAccountDoc;
            break;
        case 5:
            self.docType = LoginDoc;
            break;
    }
    if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
    {
        [_delegate DocTypeButtonTapped:self];
    }
}


@end
