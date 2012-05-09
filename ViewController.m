//
//  ViewController.m
//  Test
//
//  Created by Bruce on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEntering;
@property (nonatomic, strong) CalculatorBrain *calculatorBrain;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, weak) UIColor *operatorButtonOriginBackgroundColor;
- (void)SetOperatorButtonEnabled:(BOOL)b;
- (void)ToggleUserIsInTheMiddleOfEntering;
- (void)SetStateInEnteringNumber;
- (void)SetStateInEnteringOperator;
- (BOOL)CanEnterOperator;
- (BOOL)IsNumeric:(NSString *)s;
- (void) ToggleOperatorButton;
void GreyButton(UIButton *button);
@end

@implementation ViewController
@synthesize display = _display;
//@synthesize operatorButton = _operatorButton;
@synthesize divideButton = _divideButton;
@synthesize multiButton = _multiButton;
@synthesize minusButton = _minusButton;
@synthesize plusButton = _plusButton;
@synthesize userIsInTheMiddleOfEntering = _userIsInTheMiddleOfEntering;
@synthesize calculatorBrain = _calculatorBrain;
@synthesize numberString = _numberString;
@synthesize operatorButtonOriginBackgroundColor = _operatorButtonOriginBackgroundColor;

void GreyButton(UIButton *button)
{
    [button setBackgroundColor:[UIColor redColor]];
}

- (void)SetOperatorButtonEnabled:(BOOL)b
{
    [self.plusButton setEnabled:b];
    //[self.plusButton setBackgroundColor:[UIColor grayColor]];
    [self.minusButton setEnabled:b];
    [self.multiButton setEnabled:b];
    [self.divideButton setEnabled:b];
    if(b)
    {
        [self.plusButton setBackgroundColor:self.operatorButtonOriginBackgroundColor];
        [self.minusButton setBackgroundColor:self.operatorButtonOriginBackgroundColor];
        [self.multiButton setBackgroundColor:self.operatorButtonOriginBackgroundColor];
        [self.divideButton setBackgroundColor:self.operatorButtonOriginBackgroundColor];
    }
    if(!b)
    {
        self.operatorButtonOriginBackgroundColor = self.plusButton.backgroundColor;
        GreyButton(self.plusButton);
        GreyButton(self.minusButton);
        GreyButton(self.multiButton);
        GreyButton(self.divideButton);
    }
}

- (BOOL)IsNumeric:(NSString *)s
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}

- (CalculatorBrain *)calculatorBrain
{
    if(_calculatorBrain == nil) _calculatorBrain = [[CalculatorBrain alloc] init];
    return _calculatorBrain;
}

- (void)ToggleUserIsInTheMiddleOfEntering
{
    _userIsInTheMiddleOfEntering = !_userIsInTheMiddleOfEntering;
}

- (void)SetStateInEnteringNumber
{
    _userIsInTheMiddleOfEntering = YES;
}

- (void)SetStateInEnteringOperator
{
    _userIsInTheMiddleOfEntering = NO;
}

- (BOOL)CanEnterOperator
{
    return [self IsNumeric:[self.display text]];
}

- (void) ToggleOperatorButton
{
    
}

- (IBAction)NumberButtonPressed:(UIButton *)sender {
    NSString *number = [sender currentTitle];
    NSLog(@"number selected %@", number);
    UILabel *displayLabel = self.display;
    NSString *currentText = [displayLabel text];
    NSString *newText = nil;
    if(currentText == @"0" || !self.userIsInTheMiddleOfEntering)
    {
        newText = number;
        //self.userIsInTheMiddleOfEntering = YES;
        [self SetStateInEnteringNumber];
    }else
    {
        newText = [currentText stringByAppendingString:number];
    }
    [displayLabel setText:newText];
    [self SetOperatorButtonEnabled:YES];
}
- (IBAction)ClearPressed:(UIButton *)sender {
    [self.display setText:@"0"]; 
    [self SetOperatorButtonEnabled:NO];
    //self.userIsInTheMiddleOfEntering = NO;
    [self SetStateInEnteringOperator];
}
- (IBAction)OperatorPressed:(UIButton *)sender {
    //self.userIsInTheMiddleOfEntering = NO;
    [self SetStateInEnteringOperator];
    [self SetOperatorButtonEnabled:NO];
    
    [self.calculatorBrain pushOperator:[sender currentTitle]];
    [self.calculatorBrain pushOperand:[[self.display text] doubleValue]];
    
    [self.display setText:sender.currentTitle];
}
- (IBAction)EnterPressed:(UIButton *)sender {
    //self.userIsInTheMiddleOfEntering = NO;
    [self SetStateInEnteringOperator];
    
    [self.calculatorBrain pushOperand:[[self.display text] doubleValue]];	
    double result = [self.calculatorBrain calculate];
    NSNumber *number = [NSNumber numberWithDouble:result];
    [self.display setText:number.stringValue];
    [self SetOperatorButtonEnabled:YES];
}
- (void)viewDidUnload {
    [self setDivideButton:nil];
    [self setMultiButton:nil];
    [self setMinusButton:nil];
    [self setPlusButton:nil];
    [super viewDidUnload];
}
@end
