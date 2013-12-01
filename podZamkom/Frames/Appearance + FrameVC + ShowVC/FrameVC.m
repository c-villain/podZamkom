//
//  FrameVC.m
//  podZamkom
//
//  Created by Alexander Kraev on 07.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "FrameVC.h"


#import "MainTableVC.h"
#import "Security.h"
#import "SWRevealViewController.h"
#import "LeftMenuVC.h"

@interface FrameVC ()

@end

@implementation FrameVC

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidLoad: (NSString*)title
{
    [super viewDidLoad];
    
    [self registerForKeyboardNotifications];
    
	self.navigationItem.titleView = [ViewAppearance initViewWithGlowingTitle:title];
    //создаем кастомизированную кнопку back:
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_close.png"];
    [backButton addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    UIButton *saveButton = [ViewAppearance initCustomButtonWithImage:@"title_bar_icon_save.png"];
    [saveButton addTarget:self action:@selector(saveBtnTapped) forControlEvents:UIControlEventTouchUpInside]; //adding action
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
    //создаем подсветку навбара
    [self.view addSubview:[ViewAppearance initGlowingBoarderForNavBar]];
    
    self.enhancedKeyboard = [[KSEnhancedKeyboard alloc] init];
    self.enhancedKeyboard.delegate = self;
    
    toolbar = [self.enhancedKeyboard getToolbarWithPrevEnabled:YES NextEnabled:YES DoneEnabled:YES];
    donePressed = NO;
}

-(void)backBtnTapped
{
    [self performSelector:@selector(popCurrentViewController:) withObject:self];
}

//метод для переопределения в каждом своем классе
-(void)saveBtnTapped
{
}

- (IBAction) deleteDoc: (id)sender
{
    [self deleteBtnTapped];
}

//метод для переопределения удаления документа
-(void)deleteBtnTapped
{
    
}

-(void)showMainVC
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTableVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    LeftMenuVC *menuVC = [storyboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] initWithRearViewController:menuVC frontViewController:mainVC];
    
    mainRevealController.rearViewRevealWidth = 55; //ширина левой менюшки
    mainRevealController.rearViewRevealOverdraw = 187; //максимальный вылет левой менюшки
    mainRevealController.bounceBackOnOverdraw = NO;
    mainRevealController.stableDragOnOverdraw = YES;
    mainRevealController.bounceBackOnLeftOverdraw = NO;
    mainRevealController.stableDragOnLeftOverdraw = YES;
    
    mainRevealController.frontViewShadowRadius = 20.0f;
    mainRevealController.toggleAnimationDuration = 0.5;
    
    [mainRevealController setFrontViewPosition:FrontViewPositionRight];
    
//    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:mainRevealController];
//    [self.navigationController pushViewController:mainRevealController animated:YES];
    [self.navigationController popToViewController:mainRevealController animated:YES];
     */
}

- (void)popCurrentViewController:(UIViewController *)onWhichViewController
{
    [onWhichViewController.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextDidTouchDown
{
    NSInteger nextTag = activeField.tag + 1;
    TextField* nextResponder = (TextField *)[self.view viewWithTag:nextTag];
    if (nextResponder)
    {
        [activeField resignFirstResponder];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        activeField = nextResponder;
    }

}

- (void)previousDidTouchDown
{
    NSInteger nextTag = activeField.tag - 1;
    TextField* nextResponder = (TextField *)[self.view viewWithTag:nextTag];
    if (nextResponder)
    {
        [activeField resignFirstResponder];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }

}

-(void)customizePadButtons
{
    NSInteger nextTag = activeField.tag; //получили текущее поле
    showPrevious = NO;
    showNext = NO;
    if ((TextField *)[self.view viewWithTag:nextTag - 1] != nil)
        showPrevious = YES;
    if ((TextField *)[self.view viewWithTag:nextTag + 1] != nil)
        showNext = YES;
}
- (void)doneDidTouchDown
{
    donePressed = YES;
    [activeField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    donePressed = NO;
    activeField = textField;
    [self customizePadButtons];
    [textField setInputAccessoryView:[self.enhancedKeyboard getToolbarWithPrevEnabled:showPrevious NextEnabled:showNext DoneEnabled:YES]];
    
//    TODO!
    if (((TextField *)textField).picker != nil)
        [textField setInputView:((TextField *)textField).picker];
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    activeField = (TextField *)textView;
    [self customizePadButtons];
    [textView setInputAccessoryView:[self.enhancedKeyboard getToolbarWithPrevEnabled:showPrevious NextEnabled:showNext DoneEnabled:YES]];
    return YES;
}


//This method is responsible for add mask characters properly
- (void)formatInput:(UITextField*)aTextField string:(NSString*)aString range:(NSRange)aRange
{
    //Copying the contents of UITextField to an variable to add new chars later
    NSString* value = aTextField.text;
    
    NSString* formattedValue = value; //итоговая строка
    
    //Make sure to retrieve the newly entered char on UITextField
    aRange.length = 1;
    NSString* _mask = [((TextField*)aTextField).mask substringWithRange:aRange];
    
    //Checking if there's a char mask at current position of cursor
    if (_mask != nil) {
        NSString *regex = @"[0-9]*";
        
        NSPredicate *regextest = [NSPredicate
                                  predicateWithFormat:@"SELF MATCHES %@", regex];
        //Checking if the character at this position isn't a digit
        
        if (! [regextest evaluateWithObject:_mask])
        {
            //If the character at current position is a special char this char must be appended to the user entered text
            formattedValue = [formattedValue stringByAppendingString:_mask];
        }
        
        if (aRange.location + 1 < [((TextField*)aTextField).mask length])
        {
            //   if([_mask isEqualToString:@" "])
            //       formattedValue = [formattedValue stringByAppendingString:_mask];
            _mask = [((TextField*)aTextField).mask substringWithRange:NSMakeRange(aRange.location + 1, 1)];
            
        }
    }
    //Adding the user entered character
    formattedValue = [formattedValue stringByAppendingString:aString];
    
    //Refreshing UITextField value
    aTextField.text = formattedValue;
}

//This method comes from UITextFieldDelegate
//and this is the most important piece of mask
//functionality.
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //если текстовое поле имеет пикер, то запрещаем редактирование
    if (((TextField*)textField).picker != nil)
    {
        return NO;
    }
    if (((TextField*)textField).mask == nil)
        return YES;
    //If the length of used entered text is equals to mask length the user input must be cancelled
    if ([textField.text length] == [((TextField*)textField).mask length]) {
        if(! [string isEqualToString:@""])
            return NO;
        else
            return YES;
    }
    //If the user has started typing text on UITextField the formatting method must be called
    else if ([textField.text length] || range.location == 0) {
        if (string) {
            if(! [string isEqualToString:@""]) {
                [self formatInput:textField string:string range:range];
                return NO;
            }
            return YES;
        }
        return YES;
    }
    
    return YES;
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    
    aRect.size.height -= toolbar.frame.size.height;
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsRect(aRect, activeField.frame))
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.7];
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
        [UIView commitAnimations];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (!donePressed)
        return;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.7];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
}

-(void)showSelectedPickerObjectInActiveField:(PickerObject *)selectedPickerObject
{
    [self showInTextField:activeField selectedPickerObject:selectedPickerObject];
}

-(void)showInTextField:(UITextField*)textField selectedPickerObject:(PickerObject *)selectedPickerObject
{
    if (selectedPickerObject ==nil)
        return;
    //else:
    [textField setRightViewMode:UITextFieldViewModeAlways];
    
    //140x84 - size of image
    //35x21
    //40x24
    //50x30
    UIImageView *temp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:selectedPickerObject.image]];
    temp.frame = CGRectMake(15, 0, 50, 30);
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
    [paddingView insertSubview:temp atIndex:0];
    textField.rightView = paddingView;
    //    [activeField setText:type.name];
}

@end
