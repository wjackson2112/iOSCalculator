//
//  HistoricOperation.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "HistoricOperation.h"

#define kOperationsKey @"Operations"
#define kOperandsKey @"Operands"

@implementation HistoricOperation

//Last input states
enum {
    OPERAND,
    OPERATION,
    EVALUATION
};

- (HistoricOperation*) initWithOperations:(NSMutableArray*)operations Operands:(NSMutableArray*) operands{
    [self addOperations:operations];
    [self addOperands:operands];
    return self;
}

#pragma mark - Set Last Input Type

- (void) setLastInputOperation{
    self.lastInputType = OPERATION;
}

- (void) setLastInputOperand{
    self.lastInputType = OPERAND;
}

- (void) setLastInputEvaluation{
    self.lastInputType = EVALUATION;
}

#pragma mark - Poll Last Input Type

- (BOOL) wasLastInputOperation{
    if(self.lastInputType == OPERATION){
        return YES;
    }
    return NO;
}

- (BOOL) wasLastInputOperand{
    if(self.lastInputType == OPERAND){
        return YES;
    }
    return NO;
}

- (BOOL) wasLastInputEvaluation{
    if(self.lastInputType == EVALUATION){
        return YES;
    }
    return NO;
}

#pragma mark - Add/Remove

- (void) addOperations:(NSMutableArray*) operations{
    //self.lastInputType = OPERATION;
    for(int i = 0; i < operations.count; i++){
        [self addOperation:[operations objectAtIndex:i]];
    }
}

- (void) addOperation:(NSString*) operation
{
    self.lastInputType = OPERATION;
    if(self.operations == NULL){
        self.operations = [[NSMutableArray alloc] init];
    }
    
    [self.operations addObject:operation];
}

- (void) removeOperation{
    [self.operations removeLastObject];
}

- (void) addOperands:(NSMutableArray*) operands{
    //self.lastInputType = OPERAND;
    for(int i = 0; i < operands.count; i++){
        [self addOperand:[operands objectAtIndex:i]];
    }
}

- (void) addOperand:(NSNumber*) operand
{
    self.lastInputType = OPERAND;
    if(self.operands == NULL || [self.operands count] == 0){
        self.operands = [[NSMutableArray alloc] init];
    }
    
    [self.operands addObject:operand];
}

- (NSNumber *) removeLastOperand{
    NSNumber *retVal = [self.operands lastObject];
    [self.operands removeLastObject];
    return retVal;
}

- (void) duplicate
{
    [self.operands addObject:[self.operands lastObject]];
    [self.operations addObject:[self.operations lastObject]];
}

#pragma mark - Special Representation

- (NSString *) toString
{
    NSString *stringBuilder;
    stringBuilder = [[self.operands objectAtIndex:0] stringValue];
    for(int i = 0; i < self.operations.count; i++)
    {
            stringBuilder = [NSString stringWithFormat:@"%@ %@",stringBuilder, [self.operations objectAtIndex:i]];
    
        if(i < self.operands.count - 1){
            stringBuilder = [NSString stringWithFormat:@"%@ %@",stringBuilder, [[self.operands objectAtIndex:i + 1] stringValue]];
        }
    }
    
    return stringBuilder;
}

- (NSMutableArray*) toStringArray{
    NSMutableArray *theArray = [[NSMutableArray alloc] initWithObjects:[[self.operands objectAtIndex:0] stringValue], nil];
    for(int i = 0; i < self.operations.count; i++){
        [theArray addObject:[NSString stringWithFormat:@"%g %@", [[self.operands objectAtIndex:i + 1] floatValue], [self.operations objectAtIndex:i]]];
    }
    return theArray;
}

- (NSString *) evaluate
{
    self.lastInputType = EVALUATION;
    BOOL error = false;
    NSMutableArray *operationsCopy = self.operations;
    NSMutableArray *operandsCopy = self.operands;
    float currentEvaluation = [[operandsCopy objectAtIndex:0] floatValue];

    
    for(int i = 0; i < self.operands.count - 1; i++)
    {
        if([[operationsCopy objectAtIndex:i] isEqualToString:@"+"])
        {
            currentEvaluation += [[operandsCopy objectAtIndex:i + 1] floatValue];
        }
        else if([[operationsCopy objectAtIndex:i] isEqualToString:@"-"])
        {
            currentEvaluation -= [[operandsCopy objectAtIndex:i + 1] floatValue];
        }
        else if([[operationsCopy objectAtIndex:i] isEqualToString:@"*"])
        {
            currentEvaluation *= [[operandsCopy objectAtIndex:i + 1] floatValue];
        }
        else if([[operationsCopy objectAtIndex:i] isEqualToString:@"/"])
        {
            if([[operandsCopy objectAtIndex:i+1] floatValue] != 0)
                currentEvaluation /= [[operandsCopy objectAtIndex:i + 1] floatValue];
            else
                error = true;
        }

        
    }
    
    if(error == true){
        return [NSString stringWithFormat:@"Error"];
    }
    
    return [[NSNumber numberWithFloat:currentEvaluation] stringValue];
}

-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    HistoricOperation *another = [[HistoricOperation alloc] init];
    another.operands = [[NSMutableArray alloc] initWithArray:[self.operands copyWithZone:zone]];
    another.operations = [[NSMutableArray alloc] initWithArray:[self.operations copyWithZone:zone]];
    another.lastInputType = self.lastInputType;
    
    return another;
}

# pragma mark - NSCoding

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.operations forKey:kOperationsKey];
    [aCoder encodeObject:self.operands forKey:kOperandsKey];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self.operations = [aDecoder decodeObjectForKey:kOperationsKey];
    self.operands = [aDecoder decodeObjectForKey:kOperandsKey];
    return self;
}

@end
