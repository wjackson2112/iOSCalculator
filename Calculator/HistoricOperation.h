//
//  HistoricOperation.h
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoricOperation : NSObject <NSCopying, NSCoding>

@property (nonatomic) NSMutableArray *operations;
@property (nonatomic) NSMutableArray *operands;
@property (nonatomic) int lastInputType;

- (HistoricOperation*) initWithOperations:(NSMutableArray *)operations Operands:(NSMutableArray*)operands;

- (void) setLastInputOperation;

- (void) setLastInputOperand;

- (void) setLastInputEvaluation;

- (BOOL) wasLastInputOperation;

- (BOOL) wasLastInputOperand;

- (BOOL) wasLastInputEvaluation;

- (void) addOperands:(NSMutableArray*) operands;

- (void) addOperations:(NSMutableArray*) operations;

- (void) addOperand:(NSNumber *) operand;

- (void) addOperation:(NSString *) operation;

- (void) removeOperation;

- (void) duplicate;

- (NSString *) toString;

- (NSMutableArray *) toStringArray;

- (NSString *) evaluate;

- (void) encodeWithCoder:(NSCoder *)aCoder;

- (id) initWithCoder:(NSCoder *)aDecoder;

@end
