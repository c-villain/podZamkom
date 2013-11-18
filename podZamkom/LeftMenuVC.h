//
//  LeftMenuVC.h
//  podZamkom
//
//  Created by Alexander Kraev on 15.10.13.
//  Copyright (c) 2013 Alexander Kraev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentLib.h"

@class LeftMenuVC;

@protocol DocSortingDelegate<NSObject>

@optional
//методы для сигнализирования главному окну, что кнопка из бокового меню была нажата
- (void)DocTypeButtonTapped:(LeftMenuVC *) controller;
@end


@interface LeftMenuVC : UITableViewController

@property (weak) id<DocSortingDelegate> delegate;

@property (nonatomic, assign) DocTypeEnum docType; //свойство необходимо для того, чтобы в делегате можно было понять, кнопка с показом какого типа документов была нажата

@end
