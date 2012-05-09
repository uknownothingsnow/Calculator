//
//  CalculatorBrain.h
//  Test
//
//  Created by Bruce on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand:(double)operand;
- (double)popOperand;
- (void)pushOperator:(NSString *)calOperator;
- (NSString *)popOperator;
- (double)calculate;

@end
