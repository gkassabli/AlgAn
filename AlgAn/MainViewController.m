//
//  MainViewController.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "MainViewController.h"

#import "IntNumber.h"

#import "Job.h"
#import "JobSortDiff.h"
#import "JobSortDiv.h"

#import "Graph.h"
#import "BinaryGraph.h"
#import "PrimSpanningTree.h"
#import "Clustering.h"
#import "BinaryClustering.h"
#import "BellmanFord.h"
#import "BellmanFordNtimes.h"

#import "Knapsack.h"

@implementation MainViewController {
    Graph *_graph1;
    Graph *_graph2;
    Graph *_graph3;
    BellmanFordNtimes *_bellmanFord;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _graph = [Graph readGraphFromFile:@"clustering1"];
//    _graph = [Graph readGraphFromFile:@"clustering1test"];
//    _clustering = [Clustering new];
//    _clustering.maxClusters = 4;
//    [_clustering evaluateClusterization:_graph completionHandler:^(NSArray *clusters, CGFloat spacing) {
//        self.resultLbl.text = [NSString stringWithFormat:@"%10f", spacing];
//    }];
    
//    _binaryClustering = [BinaryClustering new];
//    _binaryGraph = [BinaryGraph readGraphFromFile:@"clustering_big"];
//    _binaryGraph = [BinaryGraph readGraphFromFile:@"clustering_big_test"];
//    [_binaryClustering evaluateClusterization:_binaryGraph distance:2 completionHandler:^(NSInteger clusters) {
//        self.resultLbl.text = [NSString stringWithFormat:@"%d", clusters];
//    }];
    
//    _knapsack = [Knapsack readKnapsackFromFile:@"knapsack_big"];
//    [_knapsack evaluateOptimumValue:^(CGFloat optimalValue) {
//        self.resultLbl.text = [NSString stringWithFormat:@"%10f", optimalValue];
//    }];

//    _graph1 = [Graph readDirectedGraphFromFile:@"gtest"];
//    _graph1 = [Graph readDirectedGraphFromFile:@"g1"];
//    _graph2 = [Graph readDirectedGraphFromFile:@"g2"];
    _graph3 = [Graph readDirectedGraphFromFile:@"g3"];
    _bellmanFord = [BellmanFordNtimes new];
    [_bellmanFord evaluateShortestForGraph:_graph3 completionHandler:^(CGFloat minPath, BOOL hasNegativeCycle) {
        if (hasNegativeCycle) {
            self.resultLbl.text = @"NULL";
        } else {
            self.resultLbl.text = [NSString stringWithFormat:@"%f", minPath];
        }
    }];
}

@end
