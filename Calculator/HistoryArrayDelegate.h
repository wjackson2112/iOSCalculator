//
//  HistoryArrayDelegate.h
//  Calculator
//
//  Created by Will Jackson on 12/29/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "History.h"

@protocol HistoryArrayDelegate <NSObject>

- (History *) history;

- (void) setHistory:(History *) history;

- (NSMutableArray *) savedHistories;

@end
