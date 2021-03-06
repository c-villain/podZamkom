//
//  AppDelegate.m
//  podZamkom
//
//  Created by Alexander Kraev on 01.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]

#import "AppDelegate.h"

@interface AppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate

- (void)startApp
{
    [self showMainVC];
    // Override point for customization after application launch.
//    if ([Security getUseOrNotPassword] || (NO == [Settings isNotFirstAppRun]) )
//        [self showLoginScreen];
//    else
//        [self showMainVC];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Settings increaseAppLaunchConting];
    return YES;
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
//    if ([_dropboxSyncDelegate respondsToSelector:@selector(stopSyncing)])
//        [_dropboxSyncDelegate stopSyncing];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (UIViewController *)topViewController{
//    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return [self topViewController:self.window.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}




- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([Security getUseOrNotPassword] || (NO == [Settings isNotFirstAppRun]) )
        [self showLoginScreen];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)PasswordVCDidSetPasscode:(PasswordVC *)controller
{
    [Security savePassword:controller.passcode];
    [Settings setNotFirstAppRun];
    [self performSelector:@selector(showMainVC) withObject:nil afterDelay:0.1];
}

- (void)PasswordVCDidEnterPasscode:(PasswordVC *)controller
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLoginScreen
{
    //если запуск первый, то выставляем дефолтный язык=)
    if (NO == [Settings isNotFirstAppRun])
        [Settings setDefaultLanguage];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PasswordVC *passwordView = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    
    if (NO == [Settings isNotFirstAppRun] ) //если первый запуск, то показываем форму в режиме установка пароля
    {
        passwordView = [passwordView initForAction:PasscodeActionSet];
        [Security saveUseOrNotPassword:YES]; //по умолч.: всегда спрашивать пароль при входе
        
    }
    else // если не первый запуск, то сравниваем введенный пароль с ранее установленным
    {
        passwordView = [passwordView initForAction:PasscodeActionEnter];
        passwordView.passcode = [Security getPassword]; //передаем пароль для сверки
        passwordView.xtraPasscode = [Security getXtraPassword]; //передаем экстренный пароль
        passwordView.deleteAfterTenErrors = [Security getDeleteorNotFilesAfterTenErrors]; //передаем удалять файлы после 10 попыток или нет
    }
    passwordView.delegate = self;
    
    [self.window.rootViewController presentViewController:passwordView
                                                 animated:NO
                                               completion:nil];
}

-(void)showMainVC //показываем главную форму после ввода пароля
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTableVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    LeftMenuVC *menuVC = [storyboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    RevealVC *mainRevealController = [[RevealVC alloc] initWithRearViewController:menuVC frontViewController:mainVC];
    
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

    [self.window.rootViewController presentViewController:mainRevealController
                                                 animated:YES
                                               completion:nil];
}

- (void)PasswordVCDidChangePasscode:(PasswordVC *)controller
{
    //поменяли пароль
    [Security savePassword:controller.passcode];
}

- (void)DeleteAllCharacters:(PasswordVC *)controller
{
    if ([DBadapter DeleteAllDocs])
        [self showMainVC];
}

- (void)PasswordVCDidEnterXtraPasscode:(PasswordVC *)controller
{
    //если пользователь ввел экстренный пароль:
    if ([DBadapter DeleteAllDocs])
        [self showMainVC];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)source annotation:(id)annotation
{
    DropboxManager *manager = [[DropboxManager alloc] init];
    if ([manager handledURL:url])
    {
        if ([_dropboxSyncDelegate respondsToSelector:@selector(linkingAccountFinished)])
            [_dropboxSyncDelegate linkingAccountFinished];
        return YES;
    }
    return NO;
}

@end
