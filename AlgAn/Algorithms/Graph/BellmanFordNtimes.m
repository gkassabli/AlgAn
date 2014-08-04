//
//  BellmanFordNtimes.m
//  AlgAn
//
//  Created by Georgiy on 8/3/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "BellmanFordNtimes.h"

#import "IntNumber.h"

#import "BellmanFord.h"

#import "Graph.h"

@implementation BellmanFordNtimes {
    BellmanFord *_bellmanFord;
}

- (void)evaluateShortestForGraph:(Graph *)graph completionHandler:(void (^)(CGFloat minPath, BOOL hasNegativeCycle))completionHandler
{
    __block CGFloat minPath = CGFLOAT_MAX;
    _bellmanFord = [BellmanFord new];
    
    for (__block NSInteger i = 0, n = [graph.nodes count]; i < n; i++) {
        [_bellmanFord evaluateShortestForGraph:graph initialIndex:i completionHandler:^(NSArray *shortestPath, BOOL hasNegativeCycle) {
            if (hasNegativeCycle) {
                i = n;
            } else {
                [shortestPath enumerateObjectsUsingBlock:^(FloatNumber *pathValue, NSUInteger idx, BOOL *stop) {
                    if (idx != i) {
                        minPath = MIN(minPath, pathValue.value);
                    }
                }];
            }
        }];
        NSLog(@"iteration %d", i);
    }
    completionHandler(minPath, minPath == CGFLOAT_MAX);
}

@end
