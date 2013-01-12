//
//  History.m
//  Calculator
//
//  Created by Will Jackson on 1/2/13.
//  Copyright (c) 2013 Will Jackson. All rights reserved.
//

#import "History.h"

#define kDataKey @"Data"
#define kDateKey @"Date"
#define kTapeKey @"Tape"
#define kNameKey @"Name"
#define kCurrFormKey @"CurrFormKey"

@implementation History

- (id)init{
    [self clear];
    self.data = [[NSMutableArray alloc] init];
    self.tape = [[NSMutableArray alloc] init];
    self.name = @"Saved Tape";
    self.date = [NSDate date];
    self.currentFormula = [[HistoricOperation alloc] init];
    return self;
}

- (BOOL) lastInputWasOperation{
    return [self.currentFormula wasLastInputOperation];
}

- (BOOL) lastInputWasOperand{
    return [self.currentFormula wasLastInputOperand];
}

- (BOOL) lastInputWasEvaluation{
    if(self.lastInputType == EVALUATION){
        return YES;
    }
    return NO;
}

- (BOOL) isTapeEmpty{
    if([self.data count] == 0){
        return YES;
    }
    return NO;
}

- (BOOL) isCurrentFormulaEmpty{
    if([self.currentFormula.operands count] == 0 && [self.currentFormula.operations count] == 0){
        return YES;
    }
    return NO;
}

- (void) addOperand:(NSNumber *) operand{
    self.lastInputType = OPERAND;
    [self.currentFormula addOperand:operand];
}

- (void) addOperation:(NSString *) operation{
    self.lastInputType = OPERATION;
    [self.currentFormula addOperation:operation];

    [self.tape addObject:[NSString stringWithFormat:@"%g %@",
                          [[self.currentFormula.operands lastObject] floatValue],
                          [self.currentFormula.operations lastObject]]];

}

- (void) addOperand:(NSNumber *)operand andOperation:(NSString *) operation{
    self.lastInputType = OPERATION;
    [self addOperand:operand];
    [self addOperation:operation];
}

-(void) duplicate{
    [self addOperand:self.currentFormula.operands.lastObject andOperation:self.currentFormula.operations.lastObject];
}

- (void) removeOperation{
    [self.currentFormula removeOperation];
}

- (void) removeOperand{
    [self.currentFormula.operands removeLastObject];
}

- (void) clear{
    self.data = [[NSMutableArray alloc] init];
    self.tape = [[NSMutableArray alloc] init];
    self.currentFormula = [[HistoricOperation alloc] init];
}

- (void) clearCurrentOperation{
    if(![self isCurrentFormulaEmpty]){
        [self.tape addObject:@"------"];
        [self.tape addObject:@""];
    }
    self.currentFormula = [[HistoricOperation alloc] init];
}

- (NSString *) evaluate{
    self.lastInputType = EVALUATION;
    if([self.currentFormula.operands count] == 1 && [self.currentFormula.operations count] == 0){
        //[self addOperand:[NSNumber numberWithFloat:[[self.data.lastObject evaluate] floatValue]]];
        if(((HistoricOperation*)(self.data.lastObject)).operations.lastObject){
            [self removeOperand];
            [self addOperand:[NSNumber numberWithFloat:[[self.data.lastObject evaluate] floatValue]]];
            [self addOperation:((HistoricOperation*)(self.data.lastObject)).operations.lastObject];
            [self addOperand:[NSNumber numberWithFloat:[((HistoricOperation*)(self.data.lastObject)).operands.lastObject floatValue]]];
        }
    }
    [self.tape addObject:[NSString stringWithFormat:@"%g =",
                          [[self.currentFormula.operands lastObject] floatValue]]];
    [self.tape addObject:@"------"];
    [self.tape addObject:[NSString stringWithFormat:@"%g", [[self.currentFormula evaluate] floatValue]]];
    [self.tape addObject:@""];
    [self.data addObject:self.currentFormula];
    self.currentFormula = [[HistoricOperation alloc] init];
    return [self.data.lastObject evaluate];
}



- (void) restoreTape{
    NSMutableArray *newTape = [[NSMutableArray alloc] init];
    for(int i = 0; i < [self.data count]; i++){
        for(int j = 0; j < [[self.data[i] operations] count]; j++){
            [newTape addObject:[NSString stringWithFormat:@"%g %@", [[[self.data[i] operands] objectAtIndex:j] floatValue], [[self.data[i] operations] objectAtIndex:j]]];
        }
        [newTape addObject:[NSString stringWithFormat:@"%g =", [[[self.data[i] operands] lastObject] floatValue]]];
        [newTape addObject:@"------"];
        [newTape addObject:[NSString stringWithFormat:@"%@", [self.data[i] evaluate]]];
        [newTape addObject:@""];
    }
    for(int i = 0; i < [self.currentFormula.operands count]; i++){
        [newTape addObject:[NSString stringWithFormat:@"%g %@", [self.currentFormula.operands[i] floatValue], self.currentFormula.operations[i]]];
    }
    self.tape = [newTape mutableCopy];
}

- (NSString *) toString{
    return [self.currentFormula toString];
}

- (NSString *) dateAndTimeToString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"MM/dd/yyyy hh:mm"];

    return [formatter stringFromDate: self.date];
}

-(id)copyWithZone:(NSZone *)zone
{
    // We'll ignore the zone for now
    History *another = [[History alloc] init];
    another.data = [[NSMutableArray alloc] initWithArray:[self.data copyWithZone: zone]];
    another.date = [self.date copyWithZone: zone];
    another.tape = [[NSMutableArray alloc] initWithArray:[self.tape copyWithZone: zone]];
    another.name = [self.name copyWithZone: zone];
    another.currentFormula = [self.currentFormula copyWithZone: zone];
    
    return another;
}


#pragma mark NSCoding

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.data forKey:kDataKey];
    [aCoder encodeObject:self.date forKey:kDateKey];
    [aCoder encodeObject:self.tape forKey:kTapeKey];
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeObject:self.currentFormula forKey:kCurrFormKey];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self.data = [aDecoder decodeObjectForKey:kDataKey];
    self.date = [aDecoder decodeObjectForKey:kDateKey];
    self.tape = [aDecoder decodeObjectForKey:kTapeKey];
    self.name = [aDecoder decodeObjectForKey:kNameKey];
    self.currentFormula = [aDecoder decodeObjectForKey:kCurrFormKey];
    return self;
}


@end
