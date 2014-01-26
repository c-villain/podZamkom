//
//  CardCRV.h
//  podZamkom
//
//  Created by Alexander Kraev on 19.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "CollectionRV.h"

@interface CardCRV : CollectionRV

@property (strong, nonatomic) IBOutlet UITextField *bankField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UITextField *typeField;
@property (strong, nonatomic) IBOutlet UITextField *validThruDate;
@property (strong, nonatomic) IBOutlet UITextField *cardHolderField;
@property (strong, nonatomic) IBOutlet UITextField *cvcField;
@property (strong, nonatomic) IBOutlet UITextField *pinField;
@property (strong, nonatomic) IBOutlet UITextField *colorField;
@property (strong, nonatomic) IBOutlet UITextView *commentField;

@property (strong, nonatomic) IBOutlet UILabel *lblBank;
@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblValid;
@property (strong, nonatomic) IBOutlet UILabel *lblHolder;
@property (strong, nonatomic) IBOutlet UILabel *lblColor;
@property (strong, nonatomic) IBOutlet UILabel *lblComments;

@end
