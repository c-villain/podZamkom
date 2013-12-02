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

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    
    //убираю разделители между строками таблицы, чтобы кастомизировать их в функции
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellDescription = @"";
    NSInteger lblTag;
    switch (indexPath.item)
    {
        case 0:
            cellDescription = [Translator languageSelectedStringForKey:@"All"];
            lblTag = 300;
            break;
        case 1:
            cellDescription = [Translator languageSelectedStringForKey:@"Notes"];
            lblTag = 301;
            break;
        case 2:
            cellDescription = [Translator languageSelectedStringForKey:@"Cards"];
            lblTag = 302;
            break;
        case 3:
            cellDescription = [Translator languageSelectedStringForKey:@"Passports"];
            lblTag = 303;
            break;
        case 4:
            cellDescription = [Translator languageSelectedStringForKey:@"Bank accounts"];
            lblTag = 304;
            break;
        case 5:
            cellDescription = [Translator languageSelectedStringForKey:@"Logins"];
            lblTag = 305;
            break;
        case 6:
            cellDescription = [Translator languageSelectedStringForKey:@"New document"];
            lblTag = 306;
            break;
    }
    
    UILabel *cellCaption = (UILabel *)[cell viewWithTag:lblTag];
    cellCaption.text = cellDescription;
    //71
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 71, 320, 2)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider_goriz.png"]];// you can also put image here
    
    [cell.contentView addSubview:separatorLineView];
    
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectionColor;
    //71
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 71, 320, 2)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider_goriz.png"]];// you can also put image here

    [cell.selectedBackgroundView addSubview:separatorLineView];
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
