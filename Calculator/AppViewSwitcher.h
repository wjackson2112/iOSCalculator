//
//  AppViewSwitcher.h
//  TapeCalc
//
//  Created by Will Jackson on 1/11/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppViewSwitcher <NSObject>

- (void) goToCalculator;

- (void) goToCurrentTape;

- (void) goToSavedTapes;

@end
