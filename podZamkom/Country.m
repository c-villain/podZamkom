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
    
    Country *country2 = [Country new];
    country2.name = @"BELGIUM";
    country2.image = @"Belgium.png";
    country2.country = BELGIUM;
    
    Country *country3 = [Country new];
    country3.name = @"BELORUSSIA";
    country3.image = @"Belarus.png";
    country3.country = BELORUSSIA;
    
    Country *country4 = [Country new];
    country4.name = @"BULGARIA";
    country4.image = @"Bulgaria.png";
    country4.country = BULGARIA;
    
    Country *country5 = [Country new];
    country5.name = @"CANADA";
    country5.image = @"Canada.png";
    country5.country = CANADA;
    
    Country *country6 = [Country new];
    country6.name = @"CHINA";
    country6.image = @"China.png";
    country6.country = CHINA;
    
    Country *country7 = [Country new];
    country7.name = @"CHROATIA";
    country7.image = @"Croatia.png";
    country7.country = CHROATIA;
    
    Country *country8 = [Country new];
    country8.name = @"CYPRUS";
    country8.image = @"Cyprus.png";
    country8.country = CYPRUS;
    
    Country *country9 = [Country new];
    country9.name = @"CZECH";
    country9.image = @"Czech.png";
    country9.country = CZECH;
    
    Country *country10 = [Country new];
    country10.name = @"DENMARK";
    country10.image = @"Denmark.png";
    country10.country = DENMARK;
    
    Country *country11 = [Country new];
    country11.name = @"FRANCE";
    country11.image = @"France.png";
    country11.country = FRANCE;
    
    Country *country12 = [Country new];
    country12.name = @"GERMANY";
    country12.image = @"Germany.png";
    country12.country = GERMANY;
    
    Country *country13 = [Country new];
    country13.name = @"GREECE";
    country13.image = @"Greece.png";
    country13.country = GREECE;
    
    Country *country14 = [Country new];
    country14.name = @"HONGKONG";
    country14.image = @"Hong-Kong.png";
    country14.country = HONGKONG;
    
    Country *country15 = [Country new];
    country15.name = @"IRELAND";
    country15.image = @"Ireland.png";
    country15.country = IRELAND;
    
    Country *country16 = [Country new];
    country16.name = @"ISRAEL";
    country16.image = @"Israel.png";
    country16.country = ISRAEL;
    
    Country *country17 = [Country new];
    country17.name = @"ITALY";
    country17.image = @"Italy.png";
    country17.country = ITALY;
    
    Country *country18 = [Country new];
    country18.name = @"JAPAN";
    country18.image = @"Japan.png";
    country18.country = JAPAN;
    
    Country *country19 = [Country new];
    country19.name = @"KAZAKHSTAN";
    country19.image = @"Kazakhstan.png";
    country19.country = KAZAKHSTAN;
    
    Country *country20 = [Country new];
    country20.name = @"MEXICO";
    country20.image = @"Mexico.png";
    country20.country = MEXICO;
    
    Country *country21 = [Country new];
    country21.name = @"NETHERLANDS";
    country21.image = @"Netherlands.png";
    country21.country = NETHERLANDS;
    
    Country *country22 = [Country new];
    country22.name = @"POLAND";
    country22.image = @"Poland.png";
    country22.country = POLAND;
    
    Country *country23 = [Country new];
    country23.name = @"PORTUGAL";
    country23.image = @"Portugal.png";
    country23.country = PORTUGAL;
    
    Country *country24 = [Country new];
    country24.name = @"RUSSIA";
    country24.image = @"Russia.png";
    country24.country = RUSSIA;
    
    Country *country25 = [Country new];
    country25.name = @"SINGAPORE";
    country25.image = @"Singapore.png";
    country25.country = SINGAPORE;
    
    Country *country26 = [Country new];
    country26.name = @"SPAIN";
    country26.image = @"Spain.png";
    country26.country = SPAIN;
    
    Country *country27 = [Country new];
    country27.name = @"SWEDEN";
    country27.image = @"Sweden.png";
    country27.country = SWEDEN;
    
    Country *country28 = [Country new];
    country28.name = @"SWITZERLAND";
    country28.image = @"Switzerland.png";
    country28.country = SWITZERLAND;
    
    Country *country29 = [Country new];
    country29.name = @"UKRAINE";
    country29.image = @"Ukraine.png";
    country29.country = UKRAINE;
    
    Country *country30 = [Country new];
    country30.name = @"USA";
    country30.image = @"USA.png";
    country30.country = USA;
    
    NSArray * array = [NSArray arrayWithObjects:country1, country2, country3, country4, country5, country6, country7, country8, country9, country10, country11, country12, country13, country14, country15, country16, country17, country18, country19, country20, country21, country22, country23, country24, country25, country26, country27, country28, country29, country30, nil];
    return array;
}

@end
