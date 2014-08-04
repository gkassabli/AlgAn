//
//  PrimSpanningTree.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class Graph;

@interface PrimSpanningTree : NSObject

- (void)evaluateSpanningTree:(Graph *)graph completionHandler:(void (^)(Graph *spanningTree, CGFloat totalCost))completionHandler;

@end
