//
//  Document.h
//  Под замком
//
//  Created by Alexander Kraev on 06.08.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NoteDoc = 0,
    CardDoc = 1,
    PassportDoc = 2,
    BankAccountDoc = 3,
    LoginDoc
} DocTypeEnum;

@interface Document : NSObject

@property (nonatomic, assign) NSInteger idDoc; //id документа
@property (nonatomic, assign) NSInteger idDocList; //id документа в таблице Doclist
@property (nonatomic, assign) DocTypeEnum docType;
@property (nonatomic, strong) NSString *docName; // имя документа
@property (nonatomic, strong) NSString *detail; // детали документа
@property (nonatomic, strong) NSString *dateOfCreation; // дата создания документа
@property (nonatomic, strong) UIView *viewWithImage;

@end
