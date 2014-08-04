//
//  BellmanFord.m
//  AlgAn
//
//  Created by Georgiy on 8/3/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "BellmanFord.h"

#import "Graph.h"
#import "Node.h"
#import "Edge.h"

#import "IntNumber.h"

@implementation BellmanFord

- (void)evaluateShortestForGraph:(Graph *)graph initialIndex:(NSInteger)initialVertex completionHandler:(void (^)(NSArray *shortestPath, BOOL hasNegativeCycle))completionHandler
{
    BOOL hasNegativeCycle = NO;
    NSUInteger nodesCount = [graph.nodes count];
    NSMutableArray *shortestPaths = [NSMutableArray arrayWithCapacity:nodesCount];
    NSMutableArray *nextShortestPath = [NSMutableArray arrayWithCapacity:nodesCount];
    for (NSInteger i = 0; i < nodesCount; i++) {
        FloatNumber *newNumber = [FloatNumber new];
        if (i != initialVertex) {
            newNumber.value = CGFLOAT_MAX;
        }
        [nextShortestPath addObject:newNumber];
        [shortestPaths addObject:[FloatNumber new]];
    }
    for (NSInteger i = 0; i < nodesCount + 1; i++) {
        for (NSInteger nodeIndex = 0; nodeIndex < nodesCount; nodeIndex++) {
            FloatNumber *nodeValue = shortestPaths[nodeIndex];
            FloatNumber *nextNodeValue = nextShortestPath[nodeIndex];
            nodeValue.value = nextNodeValue.value;
        }
        @autoreleasepool {
            for (NSInteger nodeIndex = 0; nodeIndex < nodesCount; nodeIndex++) {
                Node *node = graph.nodes[nodeIndex];
                CGFloat currentPathValue = [(FloatNumber *)shortestPaths[nodeIndex] value];
                for (Edge *edge in node.edges) {
                    NSInteger nextNodeIndex = (edge.node1 == node) ? edge.node2.number : edge.node1.number;
                    nextNodeIndex--;
                    FloatNumber *currentNextNodeValue = nextShortestPath[nextNodeIndex];
                    if (currentPathValue + edge.length < currentNextNodeValue.value) {
                        currentNextNodeValue.value = currentPathValue + edge.length;
                    }
                }
            }
        }
        if (i == nodesCount) {
            for (NSInteger nodeIndex = 0; nodeIndex < nodesCount; nodeIndex++) {
                FloatNumber *nodeValue = shortestPaths[nodeIndex];
                FloatNumber *nextNodeValue = nextShortestPath[nodeIndex];
                if (nodeValue.value != nextNodeValue.value) {
                    hasNegativeCycle = YES;
                }
            }
        }
    }
    completionHandler(shortestPaths, hasNegativeCycle);
}

@end
