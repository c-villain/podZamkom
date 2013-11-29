//
//  NewDocVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 18.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewDocVC.h"

@interface NewDocVC ()

@end

@implementation NewDocVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //подсветка заголовка:
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:[Translator languageSelectedStringForKey:@"NEW DOCUMENT"]];
    

    
    self.navigationItem.hidesBackButton = YES;
    
    //создаем кастомизированную кнопку back:
    UIButton *button = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    [button addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];
}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    NSString *cellDescription = @"";
    NSInteger lblTag;
    switch (indexPath.item)
    {
        case 0:
            cellIdentifier = @"newNote";
            cellDescription = [Translator languageSelectedStringForKey:@"NOTE"];
            lblTag = 200;
            break;
        case 1:
            cellIdentifier = @"newCard";
            cellDescription = [Translator languageSelectedStringForKey:@"CREDIT CARD"];
            lblTag = 201;
            break;
        case 2:
            cellIdentifier = @"newPassport";
            cellDescription = [Translator languageSelectedStringForKey:@"PASSPORT"];
            lblTag = 202;
            break;
        case 3:
            cellIdentifier = @"newBankAccount";
            cellDescription = [Translator languageSelectedStringForKey:@"BANK ACCOUNT"];
            lblTag = 203;
            break;
        case 4:
            cellIdentifier = @"newLogin";
            cellDescription = [Translator languageSelectedStringForKey:@"LOGIN"];
            lblTag = 204;
            break;
    }
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *cellCaption = (UILabel *)[cell viewWithTag:lblTag];
    cellCaption.text = cellDescription;

    if (cell == nil) {
        cell = (UICollectionViewCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor =[UIColor colorWithRed:59.0f/255.0f green:59.0f/255.0f blue:60.0f/255.0f alpha:1.0f].CGColor;
    return cell;
}

//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UIImage *image = [self.results objectAtIndex:indexPath.row];
//    return CGSizeMake(image.size.width, image.size.height);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(50, 20, 50, 20);
//}

@end
