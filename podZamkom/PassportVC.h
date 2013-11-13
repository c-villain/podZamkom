//
//  PassportVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 14.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "ShowVC.h"

@interface PassportVC : ShowVC
{
    Passport *passport;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Passport: (Passport*) passportDoc;

@end
