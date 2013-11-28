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


- (void) viewDidLayoutSubviews
{
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 7)
     {
         self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
     }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Remove table cell separator
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
            if ([_delegate respondsToSelector:@selector(AllDocsButtonTyped)])
            {
                [_delegate AllDocsButtonTyped];
            }
            break;
        case 1:
            if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
            {
                [_delegate DocTypeButtonTapped:NoteDoc];
            }
            break;
        case 2:
            if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
            {
                [_delegate DocTypeButtonTapped:CardDoc];
            }
            break;
        case 3:
            if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
            {
                [_delegate DocTypeButtonTapped:PassportDoc];
            }
            break;
        case 4:
            if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
            {
                [_delegate DocTypeButtonTapped:BankAccountDoc];
            }

            break;
        case 5:
            if ([_delegate respondsToSelector:@selector(DocTypeButtonTapped:)])
            {
                [_delegate DocTypeButtonTapped:LoginDoc];
            }
            break;
    }
}


@end
