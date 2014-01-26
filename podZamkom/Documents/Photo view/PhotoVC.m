//
//  PhotoVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 18.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "PhotoVC.h"

@interface PhotoVC ()

@end

@implementation PhotoVC

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
    
    //--------------------
    //создаем top bar
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    
    [navBar setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame),64)];
    [self.view addSubview:navBar];
    //--------------------
    
    [(UIView*)[navBar.subviews objectAtIndex:0] setAlpha:0.1f];
    
    //--------------------
    //создаем кастомизированную кнопку back:
    UIButton *button = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    [button addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // create a UINavigationItem and add the button in the right hand side
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    navItem.rightBarButtonItem = barButton;
    
    [navBar pushNavigationItem:navItem animated:NO];
    //--------------------
    
    
    self.colView.dataSource = self;
    self.colView.delegate = self;
    [self.colView registerClass:[PhotoViewCell class] forCellWithReuseIdentifier:@"photoShowCell"];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"login_screen_bg"]];
}

-(void)backBtnTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self.document.docPhotos.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"photoShowCell" forIndexPath:indexPath];
    UIImage *newPhoto = [self.document.docPhotos objectAtIndex:indexPath.row];
    [cell initWithImage:newPhoto];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoViewCell *cell = (PhotoViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    GGFullscreenImageViewController *vc = [[GGFullscreenImageViewController alloc] init];
    vc.supportedOrientations = UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
    vc.liftedImageView = cell.contentView.subviews[0];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
