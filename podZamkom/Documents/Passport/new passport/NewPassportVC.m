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
    NSString* title = [Translator languageSelectedStringForKey:@"NEW PASSPORT"];
    
	// Do any additional setup after loading the view.
    
    if (self.selectedDocument != nil)
    {
        title = ((Passport *)self.selectedDocument).docName;
    }
    
    [super viewDidLoad:title];

}

-(void)saveBtnTapped
{
    /*
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 3);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    */
    
    [activeField resignFirstResponder];
    CGRect size = CGRectMake(0, 0 , 150, 150);
    self.progressView = [[M13ProgressViewPie alloc] initWithFrame:size];
    
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithView:self.progressView];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal show];
    
    // how we stop refresh from freezing the main UI thread
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        Passport *passport = [Passport new];
        passport.idDoc = ((Passport *)self.selectedDocument).idDoc;
        passport.idDocList = ((Passport *)self.selectedDocument).idDocList;
        passport.docType = PassportDoc;
        passport.docName = [Translator languageSelectedStringForKey:@"Passport"];
        
        if (![[self.colView.collectionPassportCV.nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
            passport.docName = self.colView.collectionPassportCV.nameField.text;
        
        passport.country = ( (Picker *) ((TextField *)self.colView.collectionPassportCV.countryField).picker).selectedIndex;
        passport.number = self.colView.collectionPassportCV.numberField.text;
        passport.department = self.colView.collectionPassportCV.depField.text;
        passport.holder = self.colView.collectionPassportCV.holderField.text;
        passport.issueDate = self.colView.collectionPassportCV.dateIssueField.text;
        passport.departmentCode = self.colView.collectionPassportCV.depCodeField.text;
        passport.birthDate = self.colView.collectionPassportCV.birthDateField.text;
        passport.birthPlace = self.colView.collectionPassportCV.birthPlaceField.text;
        passport.docPhotos = self.photoList;
        
        [DBadapter DBSave:passport];
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView performAction:M13ProgressViewActionSuccess animated:YES];
            [self performSelector:@selector(goToRoot) withObject:nil afterDelay:self.progressView.animationDuration + .1];
        });
        
    });
    
}

- (void) goToRoot
{
    [self showMainVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind != UICollectionElementKindSectionHeader)
        return nil;
    PassportCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                           UICollectionElementKindSectionHeader withReuseIdentifier:@"passportCRV" forIndexPath:indexPath];
    self.colView.collectionPassportCV = headerView;
    
    if (firstOpenEditVC)
    {
        headerView.lblTitle.text = [Translator languageSelectedStringForKey:@"TITLE"];
        headerView.lblCountry.text = [Translator languageSelectedStringForKey:@"COUNTRY"];
        headerView.lblNumber.text = [Translator languageSelectedStringForKey:@"PASSPORT NUMBER"];
        headerView.lblIssuedBy.text = [Translator languageSelectedStringForKey:@"ISSUED BY"];
        headerView.lblIssueDate.text = [Translator languageSelectedStringForKey:@"DATE OF ISSUE"];
        headerView.lblDepCode.text = [Translator languageSelectedStringForKey:@"DEPARTMENT CODE"];
        headerView.lblHolder.text = [Translator languageSelectedStringForKey:@"SURNAME, NAME"];
        headerView.lblBirthDate.text = [Translator languageSelectedStringForKey:@"BIRTHDATE"];
        headerView.lblBirthPlace.text = [Translator languageSelectedStringForKey:@"BIRTHPLACE"];
        headerView.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
        [(TextField *)headerView.dateIssueField initWithMask:@"99.99.9999"];
        [(TextField *)headerView.birthDateField initWithMask:@"99.99.9999"];
        
        if ([[[NSLocale preferredLanguages] objectAtIndex:0]  isEqual: @"ru"])
        {
            headerView.numberField.keyboardType = UIKeyboardTypeNumberPad;
            [(TextField *)headerView.numberField initWithMask:@"99 99 999999"];
            headerView.depCodeField.keyboardType = UIKeyboardTypeNumberPad;
        }
        //инициализируем пикер (страны):
        ((TextField *)headerView.countryField).picker = [Picker createPickerWithData:[Country initCountryArray] andPickerDelegate:self];
        
        //по умолч. ставим везде пустые текстовые поля:
        headerView.nameField.text = @"";
        headerView.countryField.text = @"";
        headerView.numberField.text = @"";
        headerView.depField.text = @"";
        headerView.holderField.text = @"";
        headerView.dateIssueField.text = @"";
        headerView.depCodeField.text = @"";
        headerView.holderField.text = @"";
        headerView.birthDateField.text = @"";
        headerView.birthPlaceField.text = @"";
        
        [headerView.nameField becomeFirstResponder];

        if (((Passport *)self.selectedDocument) != nil)
        {
            [headerView.nameField resignFirstResponder];
            headerView.nameField.text = ((Passport *)self.selectedDocument).docName;
            [super showInTextField:headerView.countryField selectedPickerObject:[Country initCountryArray][((Passport *)self.selectedDocument).country]];
            headerView.numberField.text = ((Passport *)self.selectedDocument).number;
            
            headerView.depField.text = ((Passport *)self.selectedDocument).department;
            headerView.holderField.text = ((Passport *)self.selectedDocument).holder;
            headerView.dateIssueField.text = ((Passport *)self.selectedDocument).issueDate;
            headerView.depCodeField.text = ((Passport *)self.selectedDocument).departmentCode;
            headerView.holderField.text = ((Passport *)self.selectedDocument).holder;
            headerView.birthDateField.text = ((Passport *)self.selectedDocument).birthDate;
            headerView.birthPlaceField.text = ((Passport *)self.selectedDocument).birthPlace;
        }
        firstOpenEditVC = NO;
    }
    headerView.addImageDelegate = self;
    return headerView;
}

@end
