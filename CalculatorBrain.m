//
//  CalculatorBrain.m
//  Test
//
//  Created by Bruce on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *numberStack;
@property (nonatomic, strong) NSMutableArray *operatorStack;

- (double)calculate:(NSMutableArray *)stringStack;
@end

@implementation CalculatorBrain
@synthesize numberStack = _numberStack;

- (NSMutableArray *)numberStack
{
    if(_numberStack == nil) _numberStack = [[NSMutableArray alloc] init];
    return _numberStack;
}
//- (void)setStack:(NSMutableArray *)stack
//{
//    _stack = stack;
//}

@synthesize operatorStack = _operatorStack;

- (NSMutableArray *)operatorStack
{
    if(_operatorStack == nil) _operatorStack = [[NSMutableArray alloc] init];
    return _operatorStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *number = [NSNumber numberWithDouble:operand];
    [self.numberStack addObject:number];
}
- (double)popOperand
{
    NSNumber *number = [self.numberStack lastObject];
    //if(number) [self.numberStack removeObject:number];
    NSUInteger index = [self.numberStack indexOfObject:number];
    if(index)
    {
        [self.numberStack removeObjectAtIndex:index];
    }
    return [number doubleValue];
}

- (void)pushOperator:(NSString *)calOperator
{
    [self.operatorStack addObject:calOperator];
}
- (NSString *)popOperator
{
    NSString *calOperator = [self.operatorStack lastObject];
    if(calOperator) [self.operatorStack removeObject:calOperator];
    return calOperator;
}


- (double)calculate
{
    double result = 0;
    while(self.numberStack.count > 0 && self.operatorStack.count > 0)
    {
        double left = [self popOperand];
        double right = [self popOperand];
        NSString *calOperator = [self popOperator];
        if([calOperator isEqualToString:@"+"])
            result += (left + right);
        else if([calOperator isEqualToString:@"-"])
            result += (left - right);
    }
    return result;
}
- (double)calculate:(NSMutableArray *)stringStack
{
    double left = 0;
    return left;
}

@end
