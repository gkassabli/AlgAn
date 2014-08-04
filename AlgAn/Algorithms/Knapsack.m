//
//  Knapsack.m
//  AlgAn
//
//  Created by Georgiy on 7/22/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "Knapsack.h"

#import "IntNumber.h"

@implementation Knapsack

+ (instancetype)readKnapsackFromFile:(NSString *)file
{
    Knapsack *newKnapsack = [Knapsack new];
    NSString *fileText = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:file withExtension:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *knapsackStrings = [fileText componentsSeparatedByString:@"\n"];
    NSMutableArray *values;
    NSMutableArray *weights;
    for (NSInteger i = 0, n = [knapsackStrings count]; i < n; i++) {
        NSString *knapsackString = knapsackStrings[i];
        NSArray *knapsackStringComponents = [knapsackString componentsSeparatedByString:@" "];
        if ([knapsackStringComponents count] >= 2) {
            if (i == 0) {
                values = [NSMutableArray arrayWithCapacity:[knapsackStringComponents[1] integerValue]];
                weights = [NSMutableArray arrayWithCapacity:[knapsackStringComponents[1] integerValue]];
                newKnapsack->_size = [knapsackStringComponents[0] integerValue];
            } else {
                [values addObject:@([knapsackStringComponents[0] integerValue])];
                [weights addObject:@([knapsackStringComponents[1] integerValue])];
            }
        }
    }
    newKnapsack->_values = values;
    newKnapsack->_weights = weights;
    
    return newKnapsack;
}

- (void)evaluateOptimumValue:(void (^)(CGFloat optimalValue))completionHandler
{
    NSInteger itemsCount = [_values count];
    NSMutableArray *previousIterationValues = [NSMutableArray arrayWithCapacity:_size + 1];
    NSMutableArray *iterationValues = [NSMutableArray arrayWithCapacity:_size + 1];
    NSMutableArray *tmp;
    for (NSInteger i = 0; i < _size + 1; i++) {
        [previousIterationValues addObject:[FloatNumber new]];
        [iterationValues addObject:[FloatNumber new]];
    }
    for (NSInteger itemNumber = 0; itemNumber < itemsCount; itemNumber++) {
        CGFloat itemValue = [_values[itemNumber] floatValue];
        NSInteger itemWeight = [_weights[itemNumber] integerValue];
        for (NSInteger currentWeight = 0; currentWeight <= _size; currentWeight++) {
            FloatNumber *optimumValue = iterationValues[currentWeight];
            FloatNumber *prevOptimumValue = previousIterationValues[currentWeight];
            CGFloat newOptimum = prevOptimumValue.value;
            if (itemWeight <= currentWeight) {
                FloatNumber *prevOptimumValue2 = previousIterationValues[currentWeight - itemWeight];
                newOptimum = MAX(newOptimum, prevOptimumValue2.value + itemValue);
            }
            optimumValue.value = newOptimum;
        }
        tmp = previousIterationValues;
        previousIterationValues = iterationValues;
        iterationValues = tmp;
    }
    if (completionHandler) {
        FloatNumber *optimumValue = previousIterationValues[_size];
        completionHandler(optimumValue.value);
    }
}

@end
