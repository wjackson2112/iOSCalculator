//
//  HistoricOperation.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoricOperation : NSObject

@property (nonatomic) NSMutableArray *operations;
@property (nonatomic) NSMutableArray *operands;

- (void) addOperand:(NSNumber *) operand;

- (void) addOperation:(NSString *) operation;

- (void) removeOperation;

- (NSString *) toString;

- (NSString *) evaluate;

@end
