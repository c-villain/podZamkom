//
//  AppDelegate.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    TODO!
//    [self showLoginScreen];
    [self showMainVC];
    return YES;
}

-(BOOL)isNotFirstAppRun
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isNotFirstRun"];;
}

-(void)setNotFirstAppRun
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isNotFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}

-(void)showLoginScreen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Password" bundle:nil];
    PasswordVC *passwordView = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
    if (NO == [self isNotFirstAppRun] ) //если первый запуск, то показываем форму в режиме установка пароля
    {
        passwordView = [passwordView initForAction:PasscodeActionSet];
    }
    else // если не первый запуск, то сравниваем введенный пароль с ранее установленным
    {
        passwordView = [passwordView initForAction:PasscodeActionEnter];
        passwordView.passcode = [Security getPassword]; //передаем пароль для сверки
    }
    passwordView.delegate = self;
    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:passwordView];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] setRootViewController:navigationController];
//    self.window.rootViewController = passwordView;
//    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    TODO!
//    [self showLoginScreen];
    [self showMainVC];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)PasswordVCDidSetPasscode:(PasswordVC *)controller
{
    [Security savePassword:controller.passcode];
    [self setNotFirstAppRun];
    [self performSelector:@selector(showMainVC) withObject:nil afterDelay:0.1];
}

- (void)PasswordVCDidEnterPasscode:(PasswordVC *)controller
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(showMainVC) withObject:nil afterDelay:0.1];
}

-(void)showMainVC //показываем главную форму после ввода пароля
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTableVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    LeftMenuVC *menuVC = [storyboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] initWithRearViewController:menuVC frontViewController:mainVC];
    
    mainRevealController.rearViewRevealWidth = 55; //ширина левой менюшки
    mainRevealController.rearViewRevealOverdraw = 187; //максимальный вылет левой менюшки
    mainRevealController.bounceBackOnOverdraw = NO;
    mainRevealController.stableDragOnOverdraw = YES;
    mainRevealController.bounceBackOnLeftOverdraw = NO;
    mainRevealController.stableDragOnLeftOverdraw = YES;
    
    mainRevealController.frontViewShadowRadius = 20.0f;
    mainRevealController.toggleAnimationDuration = 0.5;
    
    mainRevealController.delegate = self;
    
    [mainRevealController setFrontViewPosition:FrontViewPositionRight];
    
    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:mainRevealController];
    [[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] setRootViewController:navigationController];
}

- (void)PasswordVCDidChangePasscode:(PasswordVC *)controller
{
    //поменяли пароль
    [Security savePassword:controller.passcode];
}

- (void)DeleteAllCharacters:(PasswordVC *)controller
{
//    TODO!
    //Удаляем все данные, если в настройках это указано
}


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{

}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{

}

- (void)revealController:(SWRevealViewController *)revealController willRevealRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didRevealRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willHideRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didHideRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willShowFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didShowFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willHideFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didHideFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}
@end
