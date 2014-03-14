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
//    [self reloadData];
}

//чтобы не было смещения в таблице относительно навбара
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
    
//    показываем алерт голосования:
//    если счетчик показа приложения кратен 4 (чтобы слишком уж не доставать пользвателя) и при этом, если раньше было  голосование, то смотрим на версию приложения: если версия старая, то снова просим проголосовать:)
//    если же за данную версию юзер проголосовал, то алерт уже не показываем)
//    то показываем голосовалку:
    if ((([Settings getLaunchCount] %4) == 0) && (![[Settings getCurrentVersion] isEqualToString:[Settings getVersionWhenRateUsed]]))

    {
        UIAlertView *alert  = [[UIAlertView alloc]
                               initWithTitle:[Translator languageSelectedStringForKey:@"Like this app?"]
                               message:[Translator languageSelectedStringForKey:@"Why not rate in the AppStore?"]
                               delegate:self
                               cancelButtonTitle:[Translator languageSelectedStringForKey:@"No, thanks"]
                               otherButtonTitles:[Translator languageSelectedStringForKey:@"Yes"],
                                                [Translator languageSelectedStringForKey:@"Remind me later"],
                                                nil];
        [alert show];
    }

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    RevealVC *revealController = self.revealViewController;
    if (revealController != nil)
    {
        [self.view addGestureRecognizer:revealController.panGestureRecognizer];
    }
    //делегируем возможность принимать системные сообщения о том, что нажата кнопка из менюшки
    ((LeftMenuVC *)self.revealViewController.rearViewController).delegate = self;
    
    //делегируем возможность принимать сообщения о том, что в search bar что-то ищут:
    self.revealViewController.searchDelegate = self;
    //убираю разделители между строками таблицы, чтобы кастомизировать их в функции
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    cashDocs = [DBadapter ReadData]; //записываем все документы в кэш
    documents =  [NSMutableArray arrayWithArray:cashDocs];
}

//голосование:
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) //no, thanks
    {
        [Settings setRate]; //ставим, что якобы юзер проголосовал:)
    }
    
    if (buttonIndex == 1) //yes, vote in appstore
    {
        [Settings setRate];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id780849347"]];
    }
    
    if (buttonIndex == 2) //remind later
    {
        //ignore:
    }
}

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
    static NSString *CellIdentifier = @"TableCell";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Display recipe in the table cell
    Document *doc = [documents objectAtIndex:indexPath.row];

    //ВНИМАНИЕ ШАМАНСТВО!
    //удаляю подвью во вью для рисунка, чтоб при скролле он не появлялся в других строках
    for (UIView *subview in [cell.viewWithImage subviews])
    {
        [subview removeFromSuperview];
    }
    
    cell.name.text = doc.docName;
    cell.detail.text = doc.detail;
    cell.dateOfCreation.text = doc.dateOfCreation;
    
    [cell.viewWithImage addSubview:doc.viewWithImage];
        
    ////
    //"кастомизация разделителей" высота строки 90 пикселей, а высота моего изображения 2 пикселя, поэтому рисую на высоте 88:
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 88, 320, 2)];/// change size as you need.
    separatorLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider_goriz.png"]];// you can also put image here
    
    [cell.contentView addSubview:separatorLineView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = cell.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        UIViewController *detailVC;
        Document *doc = [documents objectAtIndex:indexPath.row];
        
        doc = [DBadapter DBSelect:doc withPhotos:YES];
        switch (doc.docType) {
            case NoteDoc:
                detailVC = [[NoteVC alloc] initWithNibName:@"NoteVC" bundle:nil Note:(Note *)doc];
                break;
            case CardDoc:
                detailVC = [[CardVC alloc] initWithNibName:@"CardVC" bundle:nil Card:(CreditCard *) doc];
                break;
            case LoginDoc:
                detailVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil Login:(Login *) doc];
                break;
            case BankAccountDoc:
                detailVC = [[BankAccountVC alloc] initWithNibName:@"BankAccountVC" bundle:nil BankAccount:(BankAccount *) doc];
                break;
            case PassportDoc:
                detailVC = [[PassportVC alloc] initWithNibName:@"PassportVC" bundle:nil Passport:(Passport *)doc];
                break;
            default:
                break;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [self.navigationController pushViewController:detailVC animated:YES];
        });
        
    });
}

- (void)DocTypeButtonTapped:(DocTypeEnum) docType
{
    [documents removeAllObjects];
    for (Document* doc in cashDocs)
    {
        if (doc.docType == docType)
            [documents addObject:doc];
    }
    [self.tableView reloadData];

}

- (void)AllDocsButtonTyped
{
//    [self reloadData];
    documents =  [NSMutableArray arrayWithArray:cashDocs];
    [self.tableView reloadData];
}

#pragma mark - Search Doc Delegate

- (void)SearchDoc:(NSString *)searchText
{
    NSMutableArray *goodDocs = [[NSMutableArray alloc] init];
    NSMutableArray* badDocs = [NSMutableArray array];
    
    for (Document* doc in documents)
    {
        if ([[doc.docName lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound ||
            [[doc.detail lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound)
            [goodDocs addObject:doc];
        else
            [badDocs addObject:doc];
    }
    
    documents = goodDocs;
    [self.tableView reloadData];
}

- (void)SearchStop
{
    documents =  [NSMutableArray arrayWithArray:cashDocs];
    [self.tableView reloadData];
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
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
