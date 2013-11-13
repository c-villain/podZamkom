//
//  CurrencyType.m
//  podZamkom
//
//  Created by Alexander Kraev on 13.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "CurrencyType.h"

@implementation CurrencyType

@synthesize currencyType;

/*
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
*/

+(NSArray *)initCurrencyTypeArray
{
    CurrencyType *type1 = [CurrencyType new];
    type1.name = @"BYR";
    type1.image = @"byr.png";
    type1.currencyType = BYR;
    
    CurrencyType *type2 = [CurrencyType new];
    type2.name = @"CNY";
    type2.image = @"jpy.png";
    type2.currencyType = CNY;
    
    CurrencyType *type3 = [CurrencyType new];
    type3.name = @"CHF";
    type3.image = @"chf.png";
    type3.currencyType = CHF;
    
    CurrencyType *type4 = [CurrencyType new];
    type4.name = @"CYP";
    type4.image = @"gbp.png";
    type4.currencyType = CYP;
    
    CurrencyType *type5 = [CurrencyType new];
    type5.name = @"EUR";
    type5.image = @"eur.png";
    type5.CurrencyType = EUR;
    
    CurrencyType *type6 = [CurrencyType new];
    type6.name = @"GBP";
    type6.image = @"gbp.png";
    type6.CurrencyType = GBP;
    
    CurrencyType *type7 = [CurrencyType new];
    type7.name = @"HKD";
    type7.image = @"usd.png";
    type7.CurrencyType = HKD;
    
    CurrencyType *type8 = [CurrencyType new];
    type8.name = @"ILS";
    type8.image = @"ils.png";
    type8.CurrencyType = ILS;
    
    CurrencyType *type9 = [CurrencyType new];
    type9.name = @"JPY";
    type9.image = @"jpy.png";
    type9.CurrencyType = JPY;
    
    CurrencyType *type10 = [CurrencyType new];
    type10.name = @"RUR";
    type10.image = @"rur.png";
    type10.CurrencyType = RUR;
    
    CurrencyType *type11 = [CurrencyType new];
    type11.name = @"SEK";
    type11.image = @"cek.png";
    type11.CurrencyType = SEK;
    
    CurrencyType *type12 = [CurrencyType new];
    type12.name = @"SGD";
    type12.image = @"usd.png";
    type12.CurrencyType = SGD;
    
    CurrencyType *type13 = [CurrencyType new];
    type13.name = @"UAH";
    type13.image = @"uah.png";
    type13.CurrencyType = UAH;
    
    CurrencyType *type14 = [CurrencyType new];
    type14.name = @"USD";
    type14.image = @"usd.png";
    type14.CurrencyType = USD;
    
    NSArray * array = [NSArray arrayWithObjects:type1, type2, type3, type4, type5, type6, type7, type8, type9, type10, type11, type12, type13, type14, nil];
    return array;
}

@end
