//
//  PrimSpanningTree.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "PrimSpanningTree.h"

#import "Graph.h"
#import "Node.h"
#import "Edge.h"

@implementation PrimSpanningTree

- (void)evaluateSpanningTree:(Graph *)graph completionHandler:(void (^)(Graph *spanningTree, CGFloat totalCost))completionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        Graph *spanningTree = [Graph new];
        spanningTree.nodes = [NSMutableArray new];
        spanningTree.edges = [NSMutableSet new];
        NSMutableSet *unprocessedNodes = [NSMutableSet new];
        for (Node *node in graph.nodes) {
            Node *newNode = [Node new];
            newNode.number = node.number;
            [unprocessedNodes addObject:newNode];
            [spanningTree.nodes addObject:newNode];
        }
        NSMutableArray *unprocessedEdges = [NSMutableArray new];
        for (Edge *edge in graph.edges) {
            Edge *newEdge = [Edge new];
            newEdge.node1 = spanningTree.nodes[edge.node1.number - 1];
            newEdge.node2 = spanningTree.nodes[edge.node2.number - 1];
            newEdge.length = edge.length;
            [unprocessedEdges addObject:newEdge];
        }
        while ([unprocessedNodes count]) {
            if ([unprocessedNodes count] == [spanningTree.nodes count]) {
                [unprocessedNodes removeObject:spanningTree.nodes[0]];
            } else {
                Edge *edgeToProcess = nil;
                NSMutableArray *edgesToRemove = [NSMutableArray new];
                for (Edge *edge in unprocessedEdges) {
                    if (([unprocessedNodes containsObject:edge.node1] && ![unprocessedNodes containsObject:edge.node2]) ||
                        (![unprocessedNodes containsObject:edge.node1] && [unprocessedNodes containsObject:edge.node2])) {
                        if (!edgeToProcess || edgeToProcess.length > edge.length) {
                            edgeToProcess = edge;
                        }
                    } else if (![unprocessedNodes containsObject:edge.node1] && ![unprocessedNodes containsObject:edge.node2]) {
                        [edgesToRemove addObject:edge];
                    }
                }
                [unprocessedEdges removeObjectsInArray:edgesToRemove];
                Node *nodeToProcess = ([unprocessedNodes containsObject:edgeToProcess.node1]) ? edgeToProcess.node1 : edgeToProcess.node2;
                Node *connectedNode = ([unprocessedNodes containsObject:edgeToProcess.node1]) ? edgeToProcess.node2 : edgeToProcess.node1;
                [unprocessedNodes removeObject:nodeToProcess];
                [unprocessedEdges removeObject:edgeToProcess];
                [nodeToProcess.edges addObject:edgeToProcess];
                [connectedNode.edges addObject:edgeToProcess];
                [spanningTree.edges addObject:edgeToProcess];
            }
        }
        
        CGFloat totalCost = 0;
        for (Edge *spanningTreeEdge in spanningTree.edges) {
            totalCost += spanningTreeEdge.length;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(spanningTree, totalCost);
        });
    });
}

@end
