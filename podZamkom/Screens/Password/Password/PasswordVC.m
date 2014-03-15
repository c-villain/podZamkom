//
//  PasswordVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 03.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PasswordVC.h"

#define SLIDE_DURATION  0.3

@interface PasswordVC ()

@end

@implementation PasswordVC


- (IBAction) changeSecureTyping: (id)sender
{
    //меняем visible/invisible способ ввода пароля
    //по умолчанию ввод защищенный
    //поэтому если решили сменить ввод, то показываем пароль
    [self.visibleBtn setSelected:!self.visibleBtn.selected];
    [_fieldWithPassword setSecureTextEntry:!_fieldWithPassword.secureTextEntry];
    
}
//скрываем клаву когда тронули область не в текстовом поле
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.fieldWithPassword isFirstResponder] && [touch view] != self.fieldWithPassword) {
        [self.fieldWithPassword resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (IBAction) showHelp: (id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PasswordHelpVC *help = [storyboard instantiateViewControllerWithIdentifier:@"helpVC"];

    [self presentViewController:help animated:YES completion:nil];
}

- (id)initForAction:(PasscodeAction)action
{
    _action = action;
    switch (action)
    {
        case PasscodeActionSet:
            
            _enterPrompt = [Translator languageSelectedStringForKey:@"Set password.\nIt could be changed\n in settings."];
            break;
            
        case PasscodeActionEnter:
            _enterPrompt = [Translator languageSelectedStringForKey:@"Enter password\nfor logging into"];
            break;
    }
    return self;
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    // Do any additional setup after loading the view from its nib.
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
    self.appNameLabel.text = [Translator languageSelectedStringForKey:@"UNDER LOCK"];
    [self.forgetBtn setTitle:[Translator languageSelectedStringForKey:@"Forgot your password?"] forState:UIControlStateNormal];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Custom initialization
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"login_screen_bg"]];
    self.errorLabel.text = @"";
    
    //рисуем стрелочку для кнопки "Забыли пароль"
    //---------------
    UIImage *image = [UIImage imageNamed:@"login_screen_forgot_password_arrow.png"];
    [self.forgetBtn setImage:image forState:UIControlStateNormal];
    
    // the space between the image and text
    CGFloat spacing = 15.0;
    
    // get the size of the elements here for readability
    CGSize titleSize = self.forgetBtn.titleLabel.frame.size;
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    
    self.forgetBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + 320/2 - titleSize.width/2 + spacing, 0.0, 0.0);
    //---------------
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:35.0f/255.0f green:35.0f/255.0f blue:41.0f/255.0f alpha:1.0f]];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;

    
    [ViewAppearance setGlowToLabel:self.appNameLabel]; //подсвечиваем логотип
    
    switch (_action)
    {
        case PasscodeActionSet:
            self.fieldWithPassword.placeholder = [Translator languageSelectedStringForKey:@"SET PASSWORD"];
            self.forgetBtn.hidden = YES;
            break;
            
        case PasscodeActionEnter:
            self.fieldWithPassword.placeholder = [Translator languageSelectedStringForKey:@"ENTER PASSWORD"];
            break;
    }
    
    [self showScreenForPhase:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self passwordTextFieldEditingComplete])
        return NO;
    return YES;
}

- (BOOL)passwordTextFieldEditingComplete
{
    NSString *text = self.fieldWithPassword.text;
    if ((text.length == 0))
        return NO;
    //после того, как ввели пароль, наши действия зависят от режима ввода пароля
    switch (_action)
    {
        case PasscodeActionSet: //если мы устанавливаем новый пароль
        {
            _passcode = text;
            if ([_delegate respondsToSelector:@selector(PasswordVCDidSetPasscode:)])
                [_delegate PasswordVCDidSetPasscode:self];
            [self dismiss];
            break;
        }
        
        case PasscodeActionEnter: //если пароль уже установлен, то просим ввести пароль заново для аутентификация пользователя
            if ([text isEqualToString:_xtraPasscode]) //если пользователь ввел экстренный пароль
            {
                [self resetFailedAttempts]; //сбрасываем неправильные попытки ввода пароля
                //передаем управление в appDelegate
                
                if ([_delegate respondsToSelector:@selector(PasswordVCDidEnterXtraPasscode:)])
                {
                    [_delegate PasswordVCDidEnterXtraPasscode:self];
                }
                [self dismiss];
            }

            if ([text isEqualToString:_passcode]) //если пароли совпадают
            {
                [self resetFailedAttempts]; //сбрасываем неправильные попытки ввода пароля
                //передаем управление в appDelegate

                if ([_delegate respondsToSelector:@selector(PasswordVCDidEnterPasscode:)])
                {
                    [_delegate PasswordVCDidEnterPasscode:self];
                }
//                [self dismiss];
            }
            else //если пароли не совпадают
            {
                [self handleFailedAttempt];//увеличиваем счетчик попыток ввести пароль
                [self showScreenForPhase:0 animated:NO]; //просим еще раз ввести пароль
                self.errorLabel.text = [Translator languageSelectedStringForKey:@"Incorrect password.\nTry again."];
            }
            break;
    }
    return YES;
}

- (void)showScreenForPhase:(NSInteger)newPhase animated:(BOOL)animated
{
    CGFloat dir = (newPhase > phase) ? 1 : -1;
    if (animated)
    {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        snapshotImageView = [[UIImageView alloc] initWithImage:snapshot];
        snapshotImageView.frame = CGRectOffset(snapshotImageView.frame, -self.view.frame.size.width*dir, 0);
        [self.view addSubview:snapshotImageView];
    }
    
    phase = newPhase;
    self.fieldWithPassword.text = @"";
    
    switch (_action)
    {
        case PasscodeActionSet:
            self.messageLabel.text = _enterPrompt;
            break;
            
        case PasscodeActionEnter:
            self.messageLabel.text = _enterPrompt;
            break;
    }
    if (animated)
    {
        self.view.frame = CGRectOffset(self.view.frame, self.view.frame.size.width*dir, 0);
        [UIView animateWithDuration:SLIDE_DURATION animations:^()
         {
             self.view.frame = CGRectOffset(self.view.frame, -self.view.frame.size.width*dir, 0);
         }
        completion:^(BOOL finished)
         {
             [snapshotImageView removeFromSuperview];
             snapshotImageView = nil;
         }];
    }
    
}

- (void)resetFailedAttempts
{
    _failedAttempts = 0;
}

- (void)handleFailedAttempt
{
    if (!_deleteAfterTenErrors)
        return;
    _failedAttempts++; //увеличиваем количество попыток неправильно введеного пароля
    
     if (self.failedAttempts == 10) //если таких попыток уже 10, то удаляем данные
     {
         if ([_delegate respondsToSelector:@selector(DeleteAllCharacters:)])
         {
             [_delegate DeleteAllCharacters:self];
         }
     }
}

@end
