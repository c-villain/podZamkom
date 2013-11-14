//
//  NewPassportVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewPassportVC.h"

@implementation NewPassportVC

- (void)viewDidLoad
{
    NSString* title = @"НОВЫЙ ПАСПОРТ";
    
    [(TextField *)self.dateIssueField initWithMask:@"99.99.9999"];
    [(TextField *)self.birthDateField initWithMask:@"99.99.9999"];
    
    //инициализируем пикер (страны):
    ((TextField *)self.countryField).picker = [Picker createPickerWithData:[Country initCountryArray] andPickerDelegate:self];

    //по умолч. ставим везде пустые текстовые поля:
    self.nameField.text = @"";
    self.countryField.text = @"";
    self.numberField.text = @"";
    self.depField.text = @"";
    self.holderField.text = @"";
    self.dateIssueField.text = @"";
    self.depCodeField.text = @"";
    self.holderField.text = @"";
    self.birthDateField.text = @"";
    self.birthPlaceField.text = @"";
    
    [self.nameField becomeFirstResponder];

    //если же мы находимся в режиме редактирования, то заполняем все поля:
    if (self.selectedPassport != nil)
    {
        title = self.selectedPassport.docName;
        self.nameField.text = self.selectedPassport.docName;
        [super showInTextField:self.countryField selectedPickerObject:[Country initCountryArray][self.selectedPassport.country]];
        self.numberField.text = self.selectedPassport.number;
        
        self.depField.text = self.selectedPassport.department;
        self.holderField.text = self.selectedPassport.holder;
        self.dateIssueField.text = self.selectedPassport.issueDate;
        self.depCodeField.text = self.selectedPassport.departmentCode;
        self.holderField.text = self.selectedPassport.holder;
        self.birthDateField.text = self.selectedPassport.birthDate;
        self.birthPlaceField.text = self.selectedPassport.birthPlace;
    }
    [super viewDidLoad:title];
}

-(void)saveBtnTapped
{
    Passport *passport = [Passport new];
    passport.docType = PassportDoc;
    passport.docName = @"Паспорт";
    
    if (![[self.nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
        passport.docName = self.nameField.text;
    
    passport.country = ( (Picker *) ((TextField *)self.countryField).picker).selectedIndex;
    passport.number = self.numberField.text;
    passport.department = self.depField.text;
    passport.holder = self.holderField.text;
    passport.issueDate = self.dateIssueField.text;
    passport.departmentCode = self.depCodeField.text;
    passport.birthDate = self.birthDateField.text;
    passport.birthPlace = self.birthPlaceField.text;
    if ([DBadapter SaveDocument:passport])
        [super showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
