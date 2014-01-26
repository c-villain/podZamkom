//
//  NewLoginVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewLoginVC.h"

@implementation NewLoginVC

- (void)viewDidLoad
{
    NSString* title = [Translator languageSelectedStringForKey:@"NEW LOGIN"];
    
	// Do any additional setup after loading the view.
    
    if (self.selectedDocument != nil)
    {
        title = ((Login *)self.selectedDocument).url;
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
        
        Login *login = [Login new];
        login.idDoc = ((Login *)self.selectedDocument).idDoc;
        login.idDocList = ((Login *)self.selectedDocument).idDocList;
        login.url = [Translator languageSelectedStringForKey:@"Login"];
        
        if (![[self.colView.collectionLoginCV.urlField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  isEqual: @""])
            login.url = self.colView.collectionLoginCV.urlField.text;
        
        login.login = self.colView.collectionLoginCV.loginField.text;
        login.password = self.colView.collectionLoginCV.passwordField.text;
        login.comment = self.colView.collectionLoginCV.loginNote.text;
        login.docType = LoginDoc;
        login.docPhotos = self.photoList;
        
        [DBadapter DBSave:login];
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
    LoginCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                           UICollectionElementKindSectionHeader withReuseIdentifier:@"loginCRV" forIndexPath:indexPath];
    self.colView.collectionLoginCV = headerView;
    
    if (firstOpenEditVC)
    {
        headerView.lblUrl.text = [Translator languageSelectedStringForKey:@"URL"];
        headerView.lblLogin.text = [Translator languageSelectedStringForKey:@"LOGIN"];
        headerView.lblPassword.text = [Translator languageSelectedStringForKey:@"PASSWORD"];
        headerView.lblComment.text = [Translator languageSelectedStringForKey:@"COMMENTS"];
        headerView.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
        
        headerView.urlField.text = @"";
        headerView.loginField.text = @"";
        headerView.passwordField.text = @"";
        headerView.loginNote.text = @"";

        [headerView.urlField becomeFirstResponder];

        if (((Login *)self.selectedDocument) != nil)
        {
            [headerView.urlField resignFirstResponder];
            headerView.urlField.text = ((Login *)self.selectedDocument).url;
            headerView.loginField.text = ((Login *)self.selectedDocument).login;
            headerView.passwordField.text = ((Login *)self.selectedDocument).password;
            headerView.loginNote.text = ((Login *)self.selectedDocument).comment;
        }
        firstOpenEditVC = NO;
    }
    headerView.addImageDelegate = self;
    return headerView;
}

@end
