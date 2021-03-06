//
//  PassportVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 14.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PassportVC.h"

@interface PassportVC ()

@end

@implementation PassportVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Passport: (Passport*) passportDoc;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        passport = passportDoc;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad: passport.docName];
    // Do any additional setup after loading the view from its nib.
    [ViewAppearance setGlowToLabel:self.lblCountry];
    [ViewAppearance setGlowToLabel:self.lblIssueDate];
    [ViewAppearance setGlowToLabel:self.lblDepCode];
    [ViewAppearance setGlowToLabel:self.lblHolder];
    [ViewAppearance setGlowToLabel:self.lblBirthDate];
    [ViewAppearance setGlowToLabel:self.lblBirthPlace];

    self.country.image = [UIImage imageNamed:[Country getCurrentCountryByType:passport.country].image];
    self.numberField.text = [@"№ " stringByAppendingString: passport.number];
    self.depField.text = passport.department;
    self.depCodeField.text = passport.departmentCode;
    self.issueDateField.text = passport.issueDate;
    self.depCodeField.text = passport.departmentCode;
    self.holderField.text = passport.holder;
    self.birthDateField.text = passport.birthDate;
    self.birthPlaceField.text = passport.birthPlace;
    
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewPassportVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newPassport"];
    myController.selectedPassport = passport;
    [self.navigationController pushViewController:myController animated:YES];
}

-(void)deleteBtnTapped
{
    if ([DBadapter DeleteDocument:passport])
        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
