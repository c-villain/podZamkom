//
//  NewBankAccountVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewBankAccountVC.h"

@implementation NewBankAccountVC

- (void)viewDidLoad
{
    NSString* title = [Translator languageSelectedStringForKey:@"NEW BANK ACCOUNT"];
    
	// Do any additional setup after loading the view.
    
    if (self.selectedDocument != nil)
    {
        title = ((BankAccount *)self.selectedDocument).bank;
    }
    
    [super viewDidLoad:title];
    
}

-(void)saveBtnTapped
{
    [activeField resignFirstResponder];
    CGRect size = CGRectMake(0, 0 , 150, 150);
    self.progressView = [[M13ProgressViewPie alloc] initWithFrame:size];
    
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithView:self.progressView];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
    [modal show];    // how we stop refresh from freezing the main UI thread
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        BankAccount *account = [BankAccount new];
        account.idDoc = ((BankAccount *)self.selectedDocument).idDoc;
        account.idDocList = ((BankAccount *)self.selectedDocument).idDocList;
        account.docType = BankAccountDoc;
        account.bank = [Translator languageSelectedStringForKey:@"Bank account"];
        if (![[self.colView.collectionBankAccountCV.bankField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
            account.bank = self.colView.collectionBankAccountCV.bankField.text;
        account.accountNumber = self.colView.collectionBankAccountCV.accountField.text;
        account.curType = ( (Picker *) ((TextField *)self.colView.collectionBankAccountCV.curTypeField).picker).selectedIndex;
        account.bik = self.colView.collectionBankAccountCV.bikField.text;
        account.corNumber = self.colView.collectionBankAccountCV.corNumberField.text;
        account.inn = self.colView.collectionBankAccountCV.innField.text;
        account.kpp = self.colView.collectionBankAccountCV.kppField.text;
        account.comments = self.colView.collectionBankAccountCV.commentField.text;
        account.docPhotos = self.photoList;

        [DBadapter DBSave:account];
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView performAction:M13ProgressViewActionSuccess animated:YES];
            [super performSelector:@selector(goToRoot) withObject:nil afterDelay:self.progressView.animationDuration + .1];
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
    BankAccountCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                           UICollectionElementKindSectionHeader withReuseIdentifier:@"bankAccountCRV" forIndexPath:indexPath];
    self.colView.collectionBankAccountCV = headerView;
    
    if (firstOpenEditVC)
    {
        headerView.lblBank.text = [Translator languageSelectedStringForKey:@"BANK"];
        headerView.lblBankAccount.text = [Translator languageSelectedStringForKey:@"BANK ACCOUNT"];
        headerView.lblCurrency.text = [Translator languageSelectedStringForKey:@"CURRENCY"];
        headerView.lblBIKCode.text = [Translator languageSelectedStringForKey:@"BIK CODE"];
        headerView.lblCorrespondentAccount.text = [Translator languageSelectedStringForKey:@"CORRESPONDENT ACCOUNT"];
        headerView.lblTaxpayerID.text = [Translator languageSelectedStringForKey:@"TAXPAYER ID"];
        headerView.lblTaxRegistrationReasonCode.text = [Translator languageSelectedStringForKey:@"TAX REGISTRATION REASON CODE"];
        headerView.lblComments.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
        headerView.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
        
        //забиваем маску для нужных текстовых полей:
        [(TextField *)headerView.innField initWithMask:@"999999999999"];
        [(TextField *)headerView.bikField initWithMask:@"999999999"];
        [(TextField *)headerView.kppField initWithMask:@"99999 9999"];
        [(TextField *)headerView.accountField initWithMask:@"99999 99999 99999 99999"];
        [(TextField *)headerView.corNumberField initWithMask:@"99999 99999 99999 99999"];
        
        //инициализируем пикеры (цвета и типа):
        ((TextField *)headerView.curTypeField).picker = [Picker createPickerWithData:[CurrencyType initCurrencyTypeArray] andPickerDelegate:self];
        
        //по умолч. ставим везде пустые текстовые поля:
        headerView.bankField.text = @"";
        headerView.accountField.text = @"";
        headerView.curTypeField.text = @"";
        headerView.bikField.text = @"";
        headerView.corNumberField.text = @"";
        headerView.innField.text = @"";
        headerView.kppField.text = @"";
        headerView.commentField.text = @"";
        
        [headerView.bankField becomeFirstResponder];
        if (((BankAccount *)self.selectedDocument) != nil)
        {
            [headerView.bankField resignFirstResponder];
            headerView.bankField.text = ((BankAccount *)self.selectedDocument).bank;
            headerView.accountField.text = ((BankAccount *)self.selectedDocument).accountNumber;
            [super showInTextField:headerView.curTypeField selectedPickerObject:[CurrencyType initCurrencyTypeArray][((BankAccount *)self.selectedDocument).curType]];
            headerView.bikField.text = ((BankAccount *)self.selectedDocument).bik;
            headerView.corNumberField.text = ((BankAccount *)self.selectedDocument).corNumber;
            headerView.innField.text = ((BankAccount *)self.selectedDocument).inn;
            headerView.kppField.text = ((BankAccount *)self.selectedDocument).kpp;
            headerView.commentField.text = ((BankAccount *)self.selectedDocument).comments;
        }
        firstOpenEditVC = NO;
    }
    headerView.addImageDelegate = self;
    return headerView;
}

@end
