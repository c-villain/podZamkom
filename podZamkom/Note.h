//
//  Note.h
//  Под замком
//
//  Created by Alexander Kraev on 26.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Document.h"

@interface Note : Document

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end
