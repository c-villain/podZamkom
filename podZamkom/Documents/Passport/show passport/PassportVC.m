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

    self.lblIssueDate.text = [Translator languageSelectedStringForKey:@"DATE OF ISSUE"];
    self.lblDepCode.text = [Translator languageSelectedStringForKey:@"DEPARTMENT CODE"];
    self.lblHolder.text = [Translator languageSelectedStringForKey:@"SURNAME, NAME"];
    self.lblBirthDate.text = [Translator languageSelectedStringForKey:@"BIRTHDATE"];
    self.lblBirthPlace.text = [Translator languageSelectedStringForKey:@"BIRTHPLACE"];
    
    [self.deleteBtn setTitle:[Translator languageSelectedStringForKey:@"DELETE PASSPORT"] forState:UIControlStateNormal];
    [self.sendBtn setTitle:[Translator languageSelectedStringForKey:@"SEND PASSPORT"] forState:UIControlStateNormal];
    
    self.country.image = [UIImage imageNamed:[Country getCurrentCountryByType:passport.country].image];
    self.numberField.text = [@"№ " stringByAppendingString: passport.number];
    self.depField.text = passport.department;
    self.depCodeField.text = passport.departmentCode;
    self.issueDateField.text = passport.issueDate;
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: [Translator languageSelectedStringForKey:@"CONFIRM DELETION OF PASSPORT"]
                          
                                                   message: nil
                                                  delegate: self
                                         cancelButtonTitle:[Translator languageSelectedStringForKey:@"Cancel"]
                                         otherButtonTitles:[Translator languageSelectedStringForKey:@"Delete"],nil];
    
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        if ([DBadapter DeleteDocument:passport])
            [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = passport.number;
    [super showMessageBoxWithTitle:[Translator languageSelectedStringForKey:@"Passport number was copied"]];
}


-(void)sendBtnTapped
{
    NSMutableString *message = [[NSMutableString alloc] init];
    
    [message appendString:[Translator languageSelectedStringForKey:@"Title: "]];
    [message appendString:passport.docName];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Passport number: "]];
    [message appendString:passport.number];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Surname, name: "]];
    [message appendString:passport.holder];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Birthdate: "]];
    [message appendString:passport.birthDate];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Birthplace: "]];
    [message appendString:passport.birthPlace];
    [message appendString:@"\n"];
    [message appendString:@"Issued by: "];
    [message appendString:passport.department];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Departent code: "]];
    [message appendString:passport.departmentCode];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Date of issue: "]];
    [message appendString:passport.issueDate];
    
    [super sendMessage:message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
