//
//  PasswordVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 03.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordTextField.h"
#import "PasswordHelpVC.h"
#import "MainTableVC.h"
#import "ViewAppearance.h"

//режим для работы пароля
typedef enum {
    PasscodeActionSet,
    PasscodeActionEnter
} PasscodeAction;


@class PasswordVC;

@protocol PasswordVCDelegate <NSObject>
@optional
//методы для сигнализирования appdelegate,  что происходит с вводом пароля
- (void)PasswordVCDidChangePasscode:(PasswordVC *)controller;
- (void)PasswordVCDidEnterPasscode:(PasswordVC *)controller;
- (void)PasswordVCDidEnterXtraPasscode:(PasswordVC *)controller;
- (void)PasswordVCDidSetPasscode:(PasswordVC *)controller;
- (void)DeleteAllCharacters:(PasswordVC *)controller;
- (void)PasswordVC:(PasswordVC *)controller didFailToEnterPasscode:(NSInteger)attempts;

@end


@interface PasswordVC : UIViewController <UITextViewDelegate>
{
    UIImageView *snapshotImageView; //снэпшот для анимации
    NSInteger phase; //фаза показа view, зависит от режима работы пароля
}

- (id)initForAction:(PasscodeAction)action; //выбор режима показа формы пароля (установки нового пароля, ввода пароля, изменения пароля)

@property (readonly) PasscodeAction action; //режим

@property (weak) id<PasswordVCDelegate> delegate;

@property (strong) NSString *enterPrompt; //строка с подсказкой для режима ввода пароля

@property (strong) NSString *passcode; //введенный пароль для передачи и сравнения с паролем, введенным позже
@property (strong) NSString *xtraPasscode; //экстренный пароль
@property (nonatomic, assign) BOOL deleteAfterTenErrors; //удалять или не удалять данные после 10 попыток

@property (assign) NSInteger failedAttempts; //количество неправильных попыток ввода пароля

@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *errorLabel;
@property (nonatomic, retain) IBOutlet UILabel *appNameLabel;
@property (nonatomic, retain) IBOutlet UITextField *fieldWithPassword;
@property (nonatomic, retain) IBOutlet UIButton *visibleBtn;
@property (nonatomic, retain) IBOutlet UIButton *forgetBtn;

- (IBAction) changeSecureTyping: (id)sender; //изменение текстового поля для пароля

- (IBAction) showHelp: (id)sender; //что делать если забыли пароль

@end
