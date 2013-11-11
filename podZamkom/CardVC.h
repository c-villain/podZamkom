//
//  CardVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowVC.h"

@interface CardVC : ShowVC
{
    CreditCard *card;
}

@property (strong, nonatomic) IBOutlet UILabel *cardBank;
@property (strong, nonatomic) IBOutlet UILabel *cardNumber;
@property (strong, nonatomic) IBOutlet UILabel *cardValidThru;
@property (strong, nonatomic) IBOutlet UILabel *cardHolder;
@property (strong, nonatomic) IBOutlet UIImageView *cardColor;
@property (strong, nonatomic) IBOutlet UIImageView *cardType;
@property (strong, nonatomic) IBOutlet UILabel *cardCvc;
@property (strong, nonatomic) IBOutlet UILabel *cardPin;
@property (strong, nonatomic) IBOutlet UILabel *lblCvc;
@property (strong, nonatomic) IBOutlet UILabel *lblPin;
@property (strong, nonatomic) IBOutlet UILabel *lblComment;
@property (strong, nonatomic) IBOutlet UITextView *cardComment;

@property (strong, nonatomic) IBOutlet UIButton *deleteNote;
//@property (strong, nonatomic) IBOutlet UIButton *sendNote;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Card:(CreditCard*) cardDoc;

@end
