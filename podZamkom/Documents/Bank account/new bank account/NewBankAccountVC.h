//
//  NewBankAccountVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 21.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameVC.h"
#import "DBlib.h"
#import "TextField.h"
#import "Picker.h"

@interface NewBankAccountVC : FrameVC
{
    NSArray *curTypes; //массив типов валют
}
    
@end
