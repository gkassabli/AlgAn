//
//  Knapsack.h
//  AlgAn
//
//  Created by Georgiy on 7/22/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Knapsack : NSObject

@property (nonatomic, assign) NSInteger size;
@property (nonatomic, readonly) NSArray *weights;
@property (nonatomic, readonly) NSArray *values;

+ (instancetype)readKnapsackFromFile:(NSString *)file;

- (void)evaluateOptimumValue:(void (^)(CGFloat optimalValue))completionHandler;

@end
