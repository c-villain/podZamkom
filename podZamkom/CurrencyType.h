//
//  CurrencyType.h
//  podZamkom
//
//  Created by Alexander Kraev on 13.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PickerObject.h"

typedef enum {
    BYR = 0, //Белорусский рубль
    CNY = 1, //китайский юань
    CHF = 2, //швейцарский франк
    CYP	= 3, //Кипрский фунт
    EUR = 4, //евро
    GBP, //фунты
    HKD, //	 Гонконгский доллар
    ILS, //Новый израильский шекель
    JPY, //японская йена
    RUR, //рубль
    SEK, //шведская крона
    SGD, //сингапурский доллар
    UAH, //Гривна
    USD //доллар
    } CurrencyTypeEnum;

@interface CurrencyType : PickerObject

@property (nonatomic, assign) CurrencyTypeEnum currencyType;

+(NSArray *)initCurrencyTypeArray;
+(CurrencyType *)getCurrencyByType: (CurrencyTypeEnum) type;

@end
