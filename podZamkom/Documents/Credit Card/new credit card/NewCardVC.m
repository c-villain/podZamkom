//
//  NewCardVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewCardVC.h"

@implementation NewCardVC

- (void)viewDidLoad
{
    NSString* title = [Translator languageSelectedStringForKey:@"NEW CARD"];
    
	// Do any additional setup after loading the view.
    
    if (self.selectedDocument != nil)
    {
        title = ((CreditCard *)self.selectedDocument).bank;
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
    [modal show];
    // how we stop refresh from freezing the main UI thread
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        CreditCard *card = [CreditCard new];
        card.idDoc = ((CreditCard *)self.selectedDocument).idDoc;
        card.docType = CardDoc;
        card.idDocList = ((CreditCard *)self.selectedDocument).idDocList;
        
        card.bank = [Translator languageSelectedStringForKey:@"Bank"];
        if (![[self.colView.collectionCardCV.bankField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
            card.bank = self.colView.collectionCardCV.bankField.text;
        
        
        card.holder = self.colView.collectionCardCV.cardHolderField.text;
        card.type = ( (Picker *) ((TextField *)self.colView.collectionCardCV.typeField).picker).selectedIndex;
        card.number = self.colView.collectionCardCV.numberField.text;
        card.validThru = self.colView.collectionCardCV.validThruDate.text;
        card.cvc = self.colView.collectionCardCV.cvcField.text;
        card.pin = self.colView.collectionCardCV.pinField.text;
        card.color = (CardColorEnum)( (Picker *) ((TextField *)self.colView.collectionCardCV.colorField).picker).selectedIndex;
        card.comments = self.colView.collectionCardCV.commentField.text;
        card.docPhotos = self.photoList;
        
        [DBadapter DBSave:card];
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
    CardCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                           UICollectionElementKindSectionHeader withReuseIdentifier:@"cardCRV" forIndexPath:indexPath];
    self.colView.collectionCardCV = headerView;
    
    if (firstOpenEditVC)
    {

        headerView.lblBank.text = [Translator languageSelectedStringForKey:@"BANK"];
        headerView.lblNumber.text = [Translator languageSelectedStringForKey:@"CARD NUMBER"];
        headerView.lblType.text = [Translator languageSelectedStringForKey:@"CARD TYPE"];
        headerView.lblValid.text = [Translator languageSelectedStringForKey:@"VALID THRU"];
        headerView.lblHolder.text = [Translator languageSelectedStringForKey:@"HOLDER"];
        headerView.lblColor.text = [Translator languageSelectedStringForKey:@"CARD COLOR"];
        headerView.lblComments.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
        headerView.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
        
        //забиваем маску для нужных текстовых полей:
        [(TextField *)headerView.numberField initWithMask:@"9999 9999 9999 9999"];
        [(TextField *)headerView.validThruDate initWithMask:@"99/99"];
        [(TextField *)headerView.cvcField initWithMask:@"9999"];
        
        //инициализируем пикеры (цвета и типа):
        ((TextField *)headerView.typeField).picker = [Picker createPickerWithData:[CardType initCardTypeArray] andPickerDelegate:self];
        ((TextField *)headerView.colorField).picker = [Picker createPickerWithData:[CardColor initCardColorArray] andPickerDelegate:self];
        
        //по умолч. ставим везде пустые текстовые поля:
        headerView.bankField.text = @"";
        headerView.numberField.text = @"";
        headerView.typeField.text = @"";
        headerView.validThruDate.text = @"";
        headerView.cardHolderField.text = @"";
        headerView.cvcField.text = @"";
        headerView.pinField.text = @"";
        headerView.colorField.text = @"";
        headerView.commentField.text = @"";
        
        [headerView.bankField becomeFirstResponder];

        if (((CreditCard *)self.selectedDocument) != nil)
        {
            
            [headerView.bankField resignFirstResponder];
            headerView.bankField.text = ((CreditCard *)self.selectedDocument).bank;
            headerView.numberField.text = ((CreditCard *)self.selectedDocument).number;
            ( (Picker *) ((TextField *)headerView.typeField).picker).selectedIndex = ((CreditCard *)self.selectedDocument).type;
            ( (Picker *) ((TextField *)headerView.colorField).picker).selectedIndex = ((CreditCard *)self.selectedDocument).color;
            [super showInTextField:headerView.typeField selectedPickerObject:[CardType initCardTypeArray][((CreditCard *)self.selectedDocument).type]];
            headerView.validThruDate.text = ((CreditCard *)self.selectedDocument).validThru;
            headerView.cardHolderField.text = ((CreditCard *)self.selectedDocument).holder;
            headerView.cvcField.text = ((CreditCard *)self.selectedDocument).cvc;
            headerView.pinField.text = ((CreditCard *)self.selectedDocument).pin;
            [super showInTextField:headerView.colorField selectedPickerObject:[CardColor initCardColorArray][((CreditCard *)self.selectedDocument).color]];
            headerView.commentField.text = ((CreditCard *)self.selectedDocument).comments;
        }
        firstOpenEditVC = NO;
    }
    headerView.addImageDelegate = self;
    return headerView;
}

@end
