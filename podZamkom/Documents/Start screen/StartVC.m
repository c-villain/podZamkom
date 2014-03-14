//
//  StartVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 14.03.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "StartVC.h"

@interface StartVC ()

@end

@implementation StartVC

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
//    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = YES;
    [self startApp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startApp
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
    
    [mainRevealController setFrontViewPosition:FrontViewPositionRight];
    
    [self.navigationController pushViewController:mainRevealController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
