//
//  NoteCRV.h
//  podZamkom
//
//  Created by Alexander Kraev on 20.01.14.
//  Copyright (c) 2014 Alexander Kraev. All rights reserved.
//

#import "CollectionRV.h"

@interface NoteCRV : CollectionRV

@property (nonatomic, retain) IBOutlet UITextField *noteTitle;
@property (nonatomic, retain) IBOutlet UITextView *note;

@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblNote;

@end
