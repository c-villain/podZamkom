//
//  PasswordHelpVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 08.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAppearance.h"

@interface PasswordHelpVC : UIViewController

//@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UILabel *helpTitle;
@property (nonatomic, retain) IBOutlet UIButton *closeBtn;
@property (nonatomic, retain) IBOutlet UITextView* helpText;
@end
