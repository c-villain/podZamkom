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

//MFMessageComposeViewControllerDelegate - для смс, результат отправки:
@interface ShowVC : UIViewController <MFMessageComposeViewControllerDelegate>

- (void)viewDidLoad: (NSString*)title;

@property (nonatomic, retain) IBOutlet UIButton *deleteBtn;

- (IBAction) deleteDoc: (id)sender;

@property (nonatomic, nonatomic) IBOutlet UIButton *btnCopy;

- (IBAction) copyDoc: (id)sender;

@property (nonatomic, nonatomic) IBOutlet UIButton *sendBtn;

- (IBAction) sendDoc: (id)sender;

- (void)showMainVC;
-(void)showMessageBoxWithTitle:(NSString*)title;
-(void)sendMessage:(NSString*)message;
@end
