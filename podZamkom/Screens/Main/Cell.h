//
//  Cell.h
//  podZamkom
//
//  Created by Alexander Kraev on 28.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIView *viewWithImage;

@end
