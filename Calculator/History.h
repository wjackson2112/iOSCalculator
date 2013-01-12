//
//  History.h
//  Calculator
//
//  Created by Will Jackson on 1/2/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoricOperation.h"

@interface History : NSObject <NSCopying, NSCoding>

enum {
    OPERATION,
    OPERAND,
    EVALUATION
};

@property (nonatomic) NSString* name;
@property (nonatomic) NSDate* date;
@property (nonatomic, retain) NSMutableArray* data;
@property (nonatomic, retain) NSMutableArray* tape;
@property (nonatomic, retain) HistoricOperation* currentFormula;

@property (nonatomic) int lastInputType;

- (BOOL) lastInputWasOperation;

- (BOOL) lastInputWasOperand;

- (BOOL) lastInputWasEvaluation;

- (BOOL) isTapeEmpty;

- (BOOL) isCurrentFormulaEmpty;

- (void) addOperand:(NSNumber *) operand;

- (void) addOperation:(NSString *) operation;

- (void) removeOperand;

- (void) removeOperation;

- (void) clear;

- (void) clearCurrentOperation;

- (void) duplicate;

- (NSString *) evaluate;

- (NSString *) toString;

- (NSString *) dateAndTimeToString;

- (void) encodeWithCoder:(NSCoder *)aCoder;

- (id) initWithCoder:(NSCoder *)aDecoder;

- (void) restoreTape;

@end
