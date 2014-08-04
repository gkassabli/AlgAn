//
//  BinaryGraph.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "BinaryGraph.h"

#import "BinaryNode.h"

@implementation BinaryGraph

+ (instancetype)readGraphFromFile:(NSString *)file
{
    BinaryGraph *newGraph = [BinaryGraph new];
    NSString *fileText = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:file withExtension:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *nodeStrings = [fileText componentsSeparatedByString:@"\n"];
    newGraph.nodes = [NSMutableArray new];
    for (NSString *nodeString in nodeStrings) {
        if ([nodeString length] > 10) {
            [newGraph.nodes addObject:[BinaryNode nodeWithCode:nodeString]];
        }
    }
    return newGraph;
}


@end
