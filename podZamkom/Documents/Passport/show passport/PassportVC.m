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
        document = passportDoc;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad: ((Passport *)document).docName];
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
    
    self.country.image = [UIImage imageNamed:[Country getCurrentCountryByType:((Passport *)document).country].image];
    self.numberField.text = [@"№ " stringByAppendingString: ((Passport *)document).number];
    self.depField.text = ((Passport *)document).department;
    self.depCodeField.text = ((Passport *)document).departmentCode;
    self.issueDateField.text = ((Passport *)document).issueDate;
    self.holderField.text = ((Passport *)document).holder;
    self.birthDateField.text = ((Passport *)document).birthDate;
    self.birthPlaceField.text = ((Passport *)document).birthPlace;
}

/*
-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewPassportVC *myController = [storyboard instantiateViewControllerWithIdentifier:@"newPassport"];
    myController.selectedPassport = passport;
    [self.navigationController pushViewController:myController animated:YES];
}
*/
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
        if ([DBadapter DeleteDocument:((Passport *)document)])
            [super showMainVC];
    }
}

-(void)copyBtnTapped:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = ((Passport *)document).number;
    [super showMessageBoxWithTitle:[Translator languageSelectedStringForKey:@"Passport number was copied"]];
}


-(void)sendBtnTapped
{
    NSMutableString *message = [[NSMutableString alloc] init];
    
    [message appendString:[Translator languageSelectedStringForKey:@"Title: "]];
    [message appendString:((Passport *)document).docName];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Passport number: "]];
    [message appendString:((Passport *)document).number];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Surname, name: "]];
    [message appendString:((Passport *)document).holder];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Birthdate: "]];
    [message appendString:((Passport *)document).birthDate];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Birthplace: "]];
    [message appendString:((Passport *)document).birthPlace];
    [message appendString:@"\n"];
    [message appendString:@"Issued by: "];
    [message appendString:((Passport *)document).department];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Departent code: "]];
    [message appendString:((Passport *)document).departmentCode];
    [message appendString:@"\n"];
    [message appendString:[Translator languageSelectedStringForKey:@"Date of issue: "]];
    [message appendString:((Passport *)document).issueDate];
    
    [super sendMessage:message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
