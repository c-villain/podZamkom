//
//  Document.h
//  Под замком
//
//  Created by Alexander Kraev on 06.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject

@property (nonatomic, strong) NSString *idDoc; //id документа
@property (nonatomic, strong) NSString *docName; // имя документа
@property (nonatomic, strong) NSString *detail; // детали документа
@property (nonatomic, strong) NSString *dateOfCreation; // дата создания документа
@property (nonatomic, strong) NSString *imageFile; // рисунок для документа

@end
