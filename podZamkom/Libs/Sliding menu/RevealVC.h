//
//  RevealVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 03.12.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "SWRevealViewController.h"
#import "ViewAppearance.h"
#import "SettingsVC.h"

@protocol SearchDocDelegate<NSObject>

@optional
//методы для сигнализирования главному окну, что кнопка из бокового меню была нажата
//- (void)DocTypeButtonTapped:(LeftMenuVC *) controller;
- (void)SearchDoc:(NSString *)searchText;
- (void)SearchStop;
@end


@interface RevealVC : SWRevealViewController
{
    UISearchBar *search;
}

@property (weak) id<SearchDocDelegate> searchDelegate;

@end

#pragma mark - UIViewController(RevealVC) Category

// We add a category of UIViewController to let childViewControllers easily access their parent SWRevealViewController
@interface UIViewController(RevealVC)

- (RevealVC*)revealViewController;

@end