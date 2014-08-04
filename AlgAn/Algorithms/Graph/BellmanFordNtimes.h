//
//  BellmanFordNtimes.h
//  AlgAn
//
//  Created by Georgiy on 8/3/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class Graph;

@interface BellmanFordNtimes : NSObject

- (void)evaluateShortestForGraph:(Graph *)graph completionHandler:(void (^)(CGFloat minPath, BOOL hasNegativeCycle))completionHandler;
@end
