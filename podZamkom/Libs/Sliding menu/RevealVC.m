//
//  RevealVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 03.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "RevealVC.h"

@interface RevealVC ()

@end

@implementation RevealVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setTitle];
    [self stopEditing]; //чтобы отключить режим поиска
}

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.hidesBackButton = YES;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
//
    //создаем подсветку навбара
    [self.view addSubview: [ViewAppearance initGlowingBoarderForNavBar]];
    [self createNavBarButtons];
}

- (void)setTitle
{
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle: [Translator languageSelectedStringForKey:@"ALREADY UNDER LOCK"]];
}

- (void)createNavBarButtons
{
    [self setTitle];
    //создаем кастомизированную кнопку settings:
    UIButton *settingsBtn = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_settings.png"];
    [settingsBtn addTarget:self action:@selector(settingsBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *barButtonSettings = [[UIBarButtonItem alloc] initWithCustomView:settingsBtn];
    self.navigationItem.rightBarButtonItem = barButtonSettings;
    
    //создаем кастомизированную кнопку search:
    UIButton *searchBtn = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_search.png"];
    [searchBtn addTarget:self action:@selector(searchBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *barButtonSearch = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.leftBarButtonItem = barButtonSearch;
}

-(void)settingsBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsVC *settingsVC = [storyboard instantiateViewControllerWithIdentifier:@"settings"];
    settingsVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController pushViewController:settingsVC animated:YES];
}

-(void)searchBtnTapped
{
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    search.delegate = self;
    search.showsCancelButton = NO;
    search.barStyle = UIBarStyleBlackOpaque;
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.titleView = nil;
    //фейковая cancel кнопка
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(stopEditing)];
    [search becomeFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [search resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([_searchDelegate respondsToSelector:@selector(SearchDoc:)])
    {
        [_searchDelegate SearchDoc:searchText];
    }
}

- (void)stopEditing
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.navigationItem.leftBarButtonItem = nil;
    [search resignFirstResponder];
    
    [self createNavBarButtons];
    [UIView commitAnimations];
    
    if ([_searchDelegate respondsToSelector:@selector(SearchStop)])
    {
        [_searchDelegate SearchStop];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#pragma mark - UIViewController(RevealVC) Category

@implementation UIViewController(RevealVC)

- (RevealVC*)revealViewController
{
    UIViewController *parent = self;
    Class revealClass = [RevealVC class];
    while ( nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:revealClass] )
    {
    }
    
    return (id)parent;
}

@end




