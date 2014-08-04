//
//  Clustering.m
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "Clustering.h"

#import "Graph.h"
#import "Node.h"
#import "Edge.h"

@implementation Clustering

- (void)evaluateClusterization:(Graph *)graph completionHandler:(void (^)(NSArray *clusters, CGFloat spacing))completionHandler
{
    NSInteger clusterCount = [graph.nodes count];
    NSMutableArray *clusters = [NSMutableArray arrayWithCapacity:clusterCount];
    for (Node *node in graph.nodes) {
        [clusters addObject:[NSMutableArray arrayWithObject:node]];
    }
    NSArray *sortedEdges = [[graph.edges allObjects] sortedArrayUsingComparator:^NSComparisonResult(Edge *edge1, Edge *edge2) {
        return (edge2.length > edge1.length) ? NSOrderedAscending : NSOrderedDescending;
    }];
    NSInteger i;
    for (i = 0; ; i++) {
        Edge *edge = sortedEdges[i];
        NSMutableArray *cluster1 = clusters[edge.node1.number - 1];
        NSMutableArray *cluster2 = clusters[edge.node2.number - 1];
        if (cluster1 != cluster2) {
            if (clusterCount == _maxClusters) {
                break;
            }
            for (Node *node in cluster2) {
                [cluster1 addObject:node];
                clusters[node.number - 1] = cluster1;
            }
            clusterCount--;
        }
    }
    if (completionHandler) {
        NSLog(@"%d, %d", i, [sortedEdges[i] length]);
        completionHandler(clusters, [sortedEdges[i] length]);
    }
}

@end
