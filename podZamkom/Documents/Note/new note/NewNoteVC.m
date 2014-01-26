//
//  NewNoteVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 22.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "NewNoteVC.h"

@implementation NewNoteVC


- (void)viewDidLoad
{
    NSString* title = [Translator languageSelectedStringForKey:@"NEW NOTE"];
    
	// Do any additional setup after loading the view.

    if (self.selectedDocument != nil)
    {
        title = ((Note *)self.selectedDocument).title;
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
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        ///
        Note *note = [Note new];
        note.idDoc = ((Note *)self.selectedDocument).idDoc;
        note.idDocList = ((Note *)self.selectedDocument).idDocList;
        note.title = [Translator languageSelectedStringForKey:@"Note"];
        if (![[self.colView.collectionNoteCV.noteTitle.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
            note.title = self.colView.collectionNoteCV.noteTitle.text;
        note.content = self.colView.collectionNoteCV.note.text;
        note.docType = NoteDoc;
        note.docPhotos = self.photoList;
        
        ///

        [DBadapter DBSave:note];
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView performAction:M13ProgressViewActionSuccess animated:YES];
            [self performSelector:@selector(goToRoot) withObject:nil afterDelay:self.progressView.animationDuration + .1];
        });
        
    });
}

- (void) goToRoot
{
    [super showMainVC];
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
    NoteCRV *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"cvHeader" forIndexPath:indexPath];
    self.colView.collectionNoteCV = headerView;
    
    if (firstOpenEditVC)
    {
        headerView.lblTitle.text = [Translator languageSelectedStringForKey:@"TITLE"];
        headerView.lblNote.text = [Translator languageSelectedStringForKey:@"NOTE"];
        headerView.lblPhoto.text = [Translator languageSelectedStringForKey: @"PHOTO"];
    
        // Do any additional setup after loading the view.
    
        headerView.noteTitle.text = @"";
        headerView.note.text = @"";
        [headerView.noteTitle becomeFirstResponder];
        if (((Note *)self.selectedDocument) != nil)
        {
            [headerView.noteTitle resignFirstResponder];
            headerView.noteTitle.text = ((Note *)self.selectedDocument).title;
            headerView.note.text = ((Note *)self.selectedDocument).content;
        }
        firstOpenEditVC = NO;
    }
    headerView.addImageDelegate = self;
    return headerView;
}


@end
