//
//  ShowVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 12.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAppearance.h" //кастомизация в дизайне

#import "DocumentLib.h"
#import "NewDocViews.h"

#import "RNBlurModalView.h" //для нотификации, что скопирован текст
#import <MessageUI/MessageUI.h> //для функции посыла сообщения

#import "NewDocVCs.h"
#import "PhotoVC.h"


//MFMessageComposeViewControllerDelegate - для смс, результат отправки:
@interface ShowVC : UIViewController <MFMessageComposeViewControllerDelegate>
{
    Document *document;
}

- (void)viewDidLoad: (NSString*)title;

@property (nonatomic, retain) IBOutlet UIButton *deleteBtn;

- (IBAction) deleteDoc: (id)sender;

@property (nonatomic, nonatomic) IBOutlet UIButton *btnCopy;

- (IBAction) copyDoc: (id)sender;

@property (nonatomic, nonatomic) IBOutlet UIButton *sendBtn;
@property (nonatomic, nonatomic) IBOutlet UIButton *photoBtn;

- (IBAction) sendDoc: (id)sender;
- (IBAction) showPhotos: (id)sender;

- (void)showMainVC;
-(void)showMessageBoxWithTitle:(NSString*)title;
-(void)sendMessage:(NSString*)message;
@end
