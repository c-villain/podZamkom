//
//  Country.h
//  podZamkom
//
//  Created by Alexander Kraev on 14.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "PickerObject.h"

typedef enum {
    AUSRALIA = 0,
    BELGIUM = 1,
    BELORUSSIA = 2,
    BULGARIA = 3,
    CANADA = 4,
    CHINA,
    CHROATIA,
    CYPRUS,
    CZECH,
    DENMARK,
    FRANCE,
    GERMANY,
    GREECE,
    HONGKONG,
    IRELAND,
    ISRAEL,
    ITALY,
    JAPAN,
    KAZAKHSTAN,
    MEXICO,
    NETHERLANDS,
    POLAND,
    PORTUGAL,
    RUSSIA,
    SINGAPORE,
    SPAIN,
    SWEDEN,
    SWITZERLAND,
    UK,
    UKRAINE,
    USA
} CountryEnum;


@interface Country : PickerObject

@property (nonatomic, assign) CountryEnum country;
@property (nonatomic, assign) NSString *passport;

+(NSArray *)initCountryArray;
+(Country *)getCurrentCountryByType: (CountryEnum) type;
@end
