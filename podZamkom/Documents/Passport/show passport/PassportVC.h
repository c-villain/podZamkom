//
//  PassportVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 14.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ShowVC.h"

@interface PassportVC : ShowVC

@property (strong, nonatomic) IBOutlet UILabel *lblCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblIssueDate;
@property (strong, nonatomic) IBOutlet UILabel *lblDepCode;
@property (strong, nonatomic) IBOutlet UILabel *lblHolder;
@property (strong, nonatomic) IBOutlet UILabel *lblBirthDate;
@property (strong, nonatomic) IBOutlet UILabel *lblBirthPlace;
@property (strong, nonatomic) IBOutlet UIImageView *country;

@property (strong, nonatomic) IBOutlet UILabel *numberField;
@property (strong, nonatomic) IBOutlet UILabel *depField;
@property (strong, nonatomic) IBOutlet UILabel *issueDateField;
@property (strong, nonatomic) IBOutlet UILabel *depCodeField;
@property (strong, nonatomic) IBOutlet UILabel *holderField;
@property (strong, nonatomic) IBOutlet UILabel *birthDateField;
@property (strong, nonatomic) IBOutlet UILabel *birthPlaceField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Passport: (Passport*) passportDoc;

@end
