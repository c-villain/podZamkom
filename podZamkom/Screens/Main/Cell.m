//
//  Cell.m
//  podZamkom
//
//  Created by Alexander Kraev on 28.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
