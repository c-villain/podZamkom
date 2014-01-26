//
//  PassportCRV.h
//  podZamkom
//
//  Created by Alexander Kraev on 20.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "CollectionRV.h"

@interface PassportCRV : CollectionRV

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *countryField;
@property (strong, nonatomic) IBOutlet UITextField *numberField;
@property (strong, nonatomic) IBOutlet UITextView *depField;
@property (strong, nonatomic) IBOutlet UITextField *dateIssueField;
@property (strong, nonatomic) IBOutlet UITextField *depCodeField;
@property (strong, nonatomic) IBOutlet UITextField *holderField;
@property (strong, nonatomic) IBOutlet UITextField *birthDateField;
@property (strong, nonatomic) IBOutlet UITextView *birthPlaceField;

@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblCountry;
@property (nonatomic, retain) IBOutlet UILabel *lblNumber;
@property (nonatomic, retain) IBOutlet UILabel *lblIssuedBy;
@property (nonatomic, retain) IBOutlet UILabel *lblIssueDate;
@property (nonatomic, retain) IBOutlet UILabel *lblDepCode;
@property (nonatomic, retain) IBOutlet UILabel *lblHolder;
@property (nonatomic, retain) IBOutlet UILabel *lblBirthDate;
@property (nonatomic, retain) IBOutlet UILabel *lblBirthPlace;

@end
