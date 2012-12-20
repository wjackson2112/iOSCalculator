//
//  HistoricOperation.m
//  Calculator
//
//  Created by Will Jackson on 12/10/12.
//  Copyright (c) 2012 Will Jackson. All rights reserved.
//

#import "HistoricOperation.h"

@implementation HistoricOperation

- (void) addOperation:(NSString*) operation
{
    if(self.operations == NULL){
        self.operations = [[NSMutableArray alloc] init];
    }
    
    [self.operations addObject:operation];
}

- (void) removeOperation{
    [self.operations removeLastObject];
}

- (void) addOperand:(NSNumber*) operand
{
    if(self.operands == NULL){
        self.operands = [[NSMutableArray alloc] init];
    }
    
    [self.operands addObject:operand];
}

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

- (NSString *) evaluate
{
    BOOL error = false;
    float currentEvaluation = [[self.operands objectAtIndex:0] floatValue];
    
    for(int i = 0; i < self.operations.count; i++)
    {
        if([[self.operations objectAtIndex:i] isEqualToString:@"+"])
        {
            currentEvaluation += [[self.operands objectAtIndex:i + 1] floatValue];
        }
        else if([[self.operations objectAtIndex:i] isEqualToString:@"-"])
        {
            currentEvaluation -= [[self.operands objectAtIndex:i + 1] floatValue];
        }
        else if([[self.operations objectAtIndex:i] isEqualToString:@"*"])
        {
            currentEvaluation *= [[self.operands objectAtIndex:i + 1] floatValue];
        }
        else if([[self.operations objectAtIndex:i] isEqualToString:@"/"])
        {
            if([[self.operands objectAtIndex:i+1] floatValue] != 0)
                currentEvaluation /= [[self.operands objectAtIndex:i + 1] floatValue];
            else
                error = true;
        }
    }
    
    if(error == true){
        return [NSString stringWithFormat:@"Error"];
    }
    
    return [NSString stringWithFormat:@"%@",[NSNumber numberWithFloat:currentEvaluation]];
}

@end
