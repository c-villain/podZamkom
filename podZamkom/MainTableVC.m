//
//  MainTableVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 11.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "MainTableVC.h"

@interface MainTableVC ()

@end

@implementation MainTableVC

-(void)viewWillAppear:(BOOL)animated
{
    dbAdapter = [[DBadapter alloc] init];
    [self reloadData];
}

-(void)reloadData
{
    documents = [dbAdapter ReadData];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    
    //убираю разделители между строками таблицы, чтобы кастомизировать их в функции
    //- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone]; }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return documents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    Document *doc = [documents objectAtIndex:indexPath.row];
    UIImageView *docImageView = (UIImageView *)[cell viewWithTag:100];
    docImageView.image = [UIImage imageNamed:doc.imageFile];
    
    UILabel *docNameLabel = (UILabel *)[cell viewWithTag:101];
    docNameLabel.text = doc.docName;
    
    UILabel *docDetailLabel = (UILabel *)[cell viewWithTag:102];
    docDetailLabel.text = doc.detail;
    
    //"кастомизация разделителей" высота строки 90 пикселей, а высота моего изображения 2 пикселя, поэтому рисую на высоте 88:
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 88, 320, 2)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider_goriz.png"]];// you can also put image here
    
    [cell.contentView addSubview:separatorLineView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *detailVC;
    
    Document *doc = [documents objectAtIndex:indexPath.row];
    switch (doc.docType) {
        case NoteDoc:
            doc = [dbAdapter GetNoteDocById:(int)doc.idDoc];
            detailVC = [[NoteVC alloc] initWithNibName:@"NoteVC" bundle:nil Note:(Note *)doc];
            break;
        case CardDoc:
            doc = [dbAdapter GetCreditCardDocById:(int)doc.idDoc];
            detailVC = [[CardVC alloc] initWithNibName:@"CardVC" bundle:nil Card:(CreditCard *) doc];
            break;
        case LoginDoc:
            doc = [dbAdapter GetLoginDocById:(int)doc.idDoc];
            detailVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil Login:(Login *) doc];
            break;
        default:
            break;
    }
    
//    NSString *docType = [dbAdapter getDocTypeByDocId:doc.idDoc];
//    if ([docType isEqual: @"Заметка"])
//    {
//        Note *noteDoc = [Note new];
//        noteDoc = [dbAdapter GetNoteDocById:doc.idDoc];
//        detailVC = [[NoteVC alloc] initWithNibName:@"NoteVC" bundle:nil Note:noteDoc];
//    }
//    else if ([docType isEqual: @"Логин"])
//    {
//        Login *loginDoc = [Login new];
//        loginDoc = [dbAdapter GetLoginDocById:doc.idDoc];
//        detailVC = [[LoginDetailVC alloc] initWithNibName:@"LoginDetailVC" bundle:nil Login:loginDoc];
//    }
//    else if ([docType isEqual: @"Кредитка"])
//    {
//        CreditCard *creditCard = [CreditCard new];
//        creditCard = [dbAdapter GetCreditCardDocById:doc.idDoc];
//        detailVC = [[CreditDetailVC alloc] initWithNibName:@"CreditDetailVC" bundle:nil CreditCard:creditCard];
//    }
//    
//    [self presentPopupViewController:detailVC animationType:MJPopupViewAnimationFade];
//    [self presentViewController:detailVC animated:YES completion:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        Document *doc = [documents objectAtIndex:indexPath.row];
        if ([dbAdapter DeleteDocFromDB:doc.idDoc])
            [self reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
