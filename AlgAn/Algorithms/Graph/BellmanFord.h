//
//  BellmanFord.h
//  AlgAn
//
//  Created by Georgiy on 8/3/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class Graph;

@interface BellmanFord : NSObject

- (void)evaluateShortestForGraph:(Graph *)graph initialIndex:(NSInteger)initialVertex completionHandler:(void (^)(NSArray *shortestPath, BOOL hasNegativeCycle))completionHandler;
@end
