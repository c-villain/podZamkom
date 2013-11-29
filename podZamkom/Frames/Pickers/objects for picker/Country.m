//
//  Country.m
//  podZamkom
//
//  Created by Alexander Kraev on 14.11.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import "Country.h"

@implementation Country


@synthesize country;

+(NSArray *)initCountryArray
{
    Country *country1 = [Country new];
    country1.name = @"AUSRALIA";
    country1.image = @"Australia.png";
    country1.country = AUSRALIA;
    country1.passport = @"passport_australia.png";
    
    Country *country2 = [Country new];
    country2.name = @"BELGIUM";
    country2.image = @"Belgium.png";
    country2.country = BELGIUM;
    country2.passport = @"passport_belg.png";
    
    Country *country3 = [Country new];
    country3.name = @"BELORUSSIA";
    country3.image = @"Belarus.png";
    country3.country = BELORUSSIA;
    country3.passport = @"passport_belarus.png";
    
    Country *country4 = [Country new];
    country4.name = @"BULGARIA";
    country4.image = @"Bulgaria.png";
    country4.country = BULGARIA;
    country4.passport = @"passport_bolg.png";
    
    Country *country5 = [Country new];
    country5.name = @"CANADA";
    country5.image = @"Canada.png";
    country5.country = CANADA;
    country5.passport = @"passport_canada.png";
    
    Country *country6 = [Country new];
    country6.name = @"CHINA";
    country6.image = @"China.png";
    country6.country = CHINA;
    country6.passport = @"passport_china.png";
    
    Country *country7 = [Country new];
    country7.name = @"CHROATIA";
    country7.image = @"Croatia.png";
    country7.country = CHROATIA;
    country7.passport = @"passport_croatia.png";
    
    Country *country8 = [Country new];
    country8.name = @"CYPRUS";
    country8.image = @"Cyprus.png";
    country8.country = CYPRUS;
    country8.passport = @"passport_cyprus.png";
    
    Country *country9 = [Country new];
    country9.name = @"CZECH";
    country9.image = @"Czech.png";
    country9.country = CZECH;
    country9.passport = @"passport_czech.png";
    
    Country *country10 = [Country new];
    country10.name = @"DENMARK";
    country10.image = @"Denmark.png";
    country10.country = DENMARK;
    country10.passport = @"passport_denmark.png";
    
    Country *country11 = [Country new];
    country11.name = @"FRANCE";
    country11.image = @"France.png";
    country11.country = FRANCE;
    country11.passport = @"passport_france.png";
    
    Country *country12 = [Country new];
    country12.name = @"GERMANY";
    country12.image = @"Germany.png";
    country12.country = GERMANY;
    country12.passport = @"passport_german.png";
    
    Country *country13 = [Country new];
    country13.name = @"GREECE";
    country13.image = @"Greece.png";
    country13.country = GREECE;
    country13.passport = @"passport_greece.png";
    
    Country *country14 = [Country new];
    country14.name = @"HONGKONG";
    country14.image = @"Hong-Kong.png";
    country14.country = HONGKONG;
    country14.passport = @"passport_hongkong.png";
    
    Country *country15 = [Country new];
    country15.name = @"IRELAND";
    country15.image = @"Ireland.png";
    country15.country = IRELAND;
    country15.passport = @"passport_ireland.png";
    
    Country *country16 = [Country new];
    country16.name = @"ISRAEL";
    country16.image = @"Israel.png";
    country16.country = ISRAEL;
    country16.passport = @"passport_israel.png";
    
    Country *country17 = [Country new];
    country17.name = @"ITALY";
    country17.image = @"Italy.png";
    country17.country = ITALY;
    country17.passport = @"passport_italy.png";
    
    Country *country18 = [Country new];
    country18.name = @"JAPAN";
    country18.image = @"Japan.png";
    country18.country = JAPAN;
    country18.passport = @"passport_japan_red.png";
    
    Country *country19 = [Country new];
    country19.name = @"KAZAKHSTAN";
    country19.image = @"Kazakhstan.png";
    country19.country = KAZAKHSTAN;
    country19.passport = @"passport_kazakhstan.png";
    
    Country *country20 = [Country new];
    country20.name = @"MEXICO";
    country20.image = @"Mexico.png";
    country20.country = MEXICO;
    country20.passport = @"passport_mexico.png";
    
    Country *country21 = [Country new];
    country21.name = @"NETHERLANDS";
    country21.image = @"Netherlands.png";
    country21.country = NETHERLANDS;
    country21.passport = @"passport_netherlands.png";
    
    Country *country22 = [Country new];
    country22.name = @"POLAND";
    country22.image = @"Poland.png";
    country22.country = POLAND;
    country22.passport = @"passport_poland.png";
    
    Country *country23 = [Country new];
    country23.name = @"PORTUGAL";
    country23.image = @"Portugal.png";
    country23.country = PORTUGAL;
    country23.passport = @"passport_portugal.png";
    
    Country *country24 = [Country new];
    country24.name = @"RUSSIA";
    country24.image = @"Russia.png";
    country24.country = RUSSIA;
    country24.passport = @"passport_rf_zagran.png";
    
    Country *country25 = [Country new];
    country25.name = @"SINGAPORE";
    country25.image = @"Singapore.png";
    country25.country = SINGAPORE;
    country25.passport = @"passport_singapore.png";
    
    Country *country26 = [Country new];
    country26.name = @"SPAIN";
    country26.image = @"Spain.png";
    country26.country = SPAIN;
    country26.passport = @"passport_spain.png";
    
    Country *country27 = [Country new];
    country27.name = @"SWEDEN";
    country27.image = @"Sweden.png";
    country27.country = SWEDEN;
    country27.passport = @"passport_sweden.png";
    
    Country *country28 = [Country new];
    country28.name = @"SWITZERLAND";
    country28.image = @"Switzerland.png";
    country28.country = SWITZERLAND;
    country28.passport = @"passport_switzerland.png";
    
    Country *country29 = [Country new];
    country29.name = @"UK";
    country29.image = @"UK.png";
    country29.country = UK;
    country29.passport = @"passport_uk.png";

    Country *country30 = [Country new];
    country30.name = @"UKRAINE";
    country30.image = @"Ukraine.png";
    country30.country = UKRAINE;
    country30.passport = @"passport_ukraine.png";
    
    Country *country31 = [Country new];
    country31.name = @"USA";
    country31.image = @"USA.png";
    country31.country = USA;
    country31.passport = @"passport_usa.png";
    
    NSArray * array = [NSArray arrayWithObjects:country1, country2, country3, country4, country5, country6, country7, country8, country9, country10, country11, country12, country13, country14, country15, country16, country17, country18, country19, country20, country21, country22, country23, country24, country25, country26, country27, country28, country29, country30, country31, nil];
    return array;
}

+(Country *)getCurrentCountryByType: (CountryEnum) type
{
    NSArray *array = [Country initCountryArray];
    int64_t counter=[array count];
    Country* country = [Country new];
    for(int i=0;i<counter;i++)
    {
        Country *currentCountry=[array objectAtIndex:i];
        if (currentCountry.country == type)
            country = currentCountry;
    }
    return country;
}

@end
