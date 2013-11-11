//
//  CardVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CardVC.h"

@interface CardVC ()

@end

@implementation CardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Card:(CreditCard*) cardDoc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        card = cardDoc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad: card.bank];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
