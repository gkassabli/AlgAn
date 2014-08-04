//
//  BinaryClustering.m
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "BinaryClustering.h"

#import "BinaryGraph.h"
#import "BinaryNode.h"

@interface NSArray (SortedSearch)

- (NSInteger)indexOfObject:(id)object withComparator:(NSComparator)comparator;

@end

@implementation NSArray (SortedSearch)

- (NSInteger)indexOfObject:(id)object withComparator:(NSComparator)comparator
{
    NSInteger result = NSNotFound;
    NSInteger minId = 0;
    NSInteger maxId = [self count] - 1;
    do {
        NSInteger medianId = minId + (maxId - minId) / 2;
        id medianObject = self[medianId];
        NSComparisonResult comparison = comparator(object, medianObject);
        if (comparison == NSOrderedSame) {
            result = medianId;
            break;
        } else {
            if (maxId == minId) {
                break;
            }
            if (comparison == NSOrderedAscending) {
                if (maxId == medianId) {
                    maxId = minId;
                } else {
                    maxId = medianId;
                }
            } else {
                if (minId == medianId) {
                    minId = maxId;
                } else {
                    minId = medianId;
                }
            }
        }
    } while (maxId >= minId);
    return result;
}

@end

@implementation BinaryClustering

- (void)evaluateClusterization:(BinaryGraph *)graph distance:(NSInteger)distance completionHandler:(void (^)(NSInteger clusters))completionHandler
{
    NSMutableArray *clusters = [NSMutableArray arrayWithCapacity:[graph.nodes count]];
    for (NSInteger i = 0, n = [graph.nodes count]; i < n; i++) {
        [clusters addObject:@(i)];
    }
    NSComparator nodeComparator = ^(BinaryNode *node1, BinaryNode *node2)  {
        if (node1.nodeValue < node2.nodeValue) {
            return NSOrderedAscending;
        } else if (node1.nodeValue > node2.nodeValue) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    };
    NSArray *nearbyNodes;
    NSArray *sortedNodes = [graph.nodes sortedArrayUsingComparator:nodeComparator];
    for (NSInteger activeI = 0, n = [sortedNodes count]; activeI < n; activeI++) {
        NSInteger activeNodeRoot = activeI;
        do {
            activeNodeRoot = [clusters[activeNodeRoot] integerValue];
        } while (activeNodeRoot != [clusters[activeNodeRoot] integerValue]);
        clusters[activeI] = @(activeNodeRoot);
        BinaryNode *node = sortedNodes[activeI];
        @autoreleasepool {
            nearbyNodes = [node nodeValuesWithDistance:distance];
            for (BinaryNode *nearbyNode in nearbyNodes) {
                if (nearbyNode.nodeValue >= node.nodeValue) {
                    NSInteger nearbyNodeIndex = [sortedNodes indexOfObject:nearbyNode withComparator:nodeComparator];
                    if (nearbyNodeIndex != NSNotFound) {
                        NSInteger nearbyNodeRoot = nearbyNodeIndex;
                        do {
                            NSInteger nextNearbyRoot = [clusters[nearbyNodeRoot] integerValue];
                            clusters[nearbyNodeRoot] = @(activeNodeRoot);
                            nearbyNodeRoot = nextNearbyRoot;
                        } while (nearbyNodeRoot != [clusters[nearbyNodeRoot] integerValue]);
                        clusters[nearbyNodeRoot] = @(activeNodeRoot);
                    }
                }
            }
        }
    }
    NSInteger clusterAmount = 0;
    for (NSInteger clusterNumber = 0; clusterNumber < [clusters count]; clusterNumber++) {
        if (clusterNumber == [clusters[clusterNumber] integerValue]) {
            clusterAmount++;
        }
    }
    if (completionHandler) {
        completionHandler(clusterAmount);
    }
}

@end
