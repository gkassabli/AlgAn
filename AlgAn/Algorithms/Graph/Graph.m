//
//  Graph.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "Graph.h"

#import "Node.h"
#import "Edge.h"

@implementation Graph {
}

+ (instancetype)readGraphFromFile:(NSString *)file
{
    return [self readGraphFromFile:file directed:NO];
}

+ (instancetype)readDirectedGraphFromFile:(NSString *)file
{
    return [self readGraphFromFile:file directed:YES];
}

+ (instancetype)readGraphFromFile:(NSString *)file directed:(BOOL)directed
{
    Graph *newGraph = [Graph new];
    newGraph->_directed = directed;
    NSString *fileText = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:file withExtension:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *jobStrings = [fileText componentsSeparatedByString:@"\n"];
    NSInteger nodeCount = [jobStrings[0] integerValue];
    newGraph.edges = [NSMutableSet new];
    newGraph.nodes = [NSMutableArray new];
    for (NSInteger i = 0; i < nodeCount; i++) {
        Node *newNode = [Node new];
        newNode.number = i + 1;
        [newGraph.nodes addObject:newNode];
    }
    [jobStrings enumerateObjectsUsingBlock:^(NSString *jobString, NSUInteger idx, BOOL *stop) {
        NSArray *jobComponents = [jobString componentsSeparatedByString:@" "];
        if ([jobComponents count] == 3 && idx != 0) {
            Edge *newEdge = [Edge new];
            newEdge.node1 = newGraph.nodes[[jobComponents[0] integerValue] - 1];
            newEdge.node2 = newGraph.nodes[[jobComponents[1] integerValue] - 1];
            newEdge.length = [jobComponents[2] integerValue];
            [newEdge.node1.edges addObject:newEdge];
            if (!directed) {
                [newEdge.node2.edges addObject:newEdge];
            }
            [newGraph.edges addObject:newEdge];
        }
    }];
    return newGraph;
}

@end
