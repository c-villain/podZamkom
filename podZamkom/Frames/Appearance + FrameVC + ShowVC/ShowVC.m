//
//  ShowVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ShowVC.h"

#import "MainTableVC.h"
#import "Security.h"
#import "SWRevealViewController.h"
#import "LeftMenuVC.h"

@interface ShowVC ()

@end

@implementation ShowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad: (NSString*)title
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:title];
    //создаем кастомизированную кнопку back:
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_back.png"];
    [backButton addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;

    UIButton *saveButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_edit.png"];
    [saveButton addTarget:self action:@selector(editBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];
    
    
    //создаем надпись для кнопки фотокопии:
    NSString *photoBtnTitle = @"";
    photoBtnTitle = [photoBtnTitle stringByAppendingString:[Translator languageSelectedStringForKey: @"PHOTOS ("]];
    
    NSString *photosCount = [NSString stringWithFormat: @"%lu", (unsigned long)document.docPhotos.count];
    photoBtnTitle = [photoBtnTitle stringByAppendingString:photosCount];
    photoBtnTitle = [photoBtnTitle stringByAppendingString:@")"];
    [self.photoBtn setTitle: photoBtnTitle  forState:UIControlStateNormal];
}

-(void)backBtnTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)showMainVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTableVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    LeftMenuVC *menuVC = [storyboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    RevealVC *mainRevealController = [[RevealVC alloc] initWithRearViewController:menuVC frontViewController:mainVC];
    
    mainRevealController.rearViewRevealWidth = 55; //ширина левой менюшки
    mainRevealController.rearViewRevealOverdraw = 187; //максимальный вылет левой менюшки
    mainRevealController.bounceBackOnOverdraw = NO;
    mainRevealController.stableDragOnOverdraw = YES;
    mainRevealController.bounceBackOnLeftOverdraw = NO;
    mainRevealController.stableDragOnLeftOverdraw = YES;
    
    mainRevealController.frontViewShadowRadius = 20.0f;
    mainRevealController.toggleAnimationDuration = 0.5;
    
    
    [mainRevealController setFrontViewPosition:FrontViewPositionRight];
    
    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:mainRevealController];
    [self.view.window setRootViewController:navigationController];
}

-(void)editBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FrameVC* myController;
    
    switch (document.docType)
    {
        case NoteDoc:
            myController = [storyboard instantiateViewControllerWithIdentifier:@"newNote"];
            myController.selectedDocument = document;
            break;
        case CardDoc:
            myController = [storyboard instantiateViewControllerWithIdentifier:@"newCard"];
            myController.selectedDocument = document;
            break;
        case LoginDoc:
            myController = [storyboard instantiateViewControllerWithIdentifier:@"newLogin"];
            myController.selectedDocument = document;
            break;
        case BankAccountDoc:
            myController = [storyboard instantiateViewControllerWithIdentifier:@"newBankAccount"];
            myController.selectedDocument = document;
            break;
        case PassportDoc:
            myController = [storyboard instantiateViewControllerWithIdentifier:@"newPassport"];
            myController.selectedDocument = document;
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:myController animated:YES];
}

- (IBAction) deleteDoc: (id)sender
{
    [self deleteBtnTapped];
}

-(void)deleteBtnTapped
{
}

- (IBAction) copyDoc: (id)sender
{
    [self copyBtnTapped:sender];
}

-(void)copyBtnTapped:(id)sender
{
}

- (IBAction) sendDoc: (id)sender
{
    [self sendBtnTapped];
}

- (IBAction) showPhotos: (id)sender
{
    [self photoBtnTapped];
}

-(void)photoBtnTapped
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PhotoVC *photoView = [storyboard instantiateViewControllerWithIdentifier:@"photoView"];
    photoView.document = document;
    [self presentViewController:photoView animated:YES completion:nil];
}

-(void)sendBtnTapped
{
    
}

-(void)sendMessage:(NSString*)message
{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setBody:message];
    
    [self presentViewController:messageController animated:YES completion:nil];
}

//для смс, результат отправки:
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            break;
        }
            
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showMessageBoxWithTitle:(NSString*)title
{
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithLogo:@"title_bar_icon_save.png" withTitle:title message:nil];
    modal.dismissButtonRight = YES;
    [modal hideCloseButton:YES];
//    [modal showWithDuration:0.3f delay:0.4 options:UIViewAnimationOptionTransitionNone completion:^{
    [modal showWithDuration:0.3f delay:0.4 options:UIViewAnimationOptionLayoutSubviews completion:^{
        [modal hideWithDuration:0.3f delay:0.4 options:UIViewAnimationOptionLayoutSubviews completion:nil];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
