//
//  BinaryNode.m
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "BinaryNode.h"

@implementation BinaryNode

+ (instancetype)nodeWithValue:(NSInteger)value
{
    BinaryNode *node = [BinaryNode new];
    node.nodeValue = value;
    return node;
}

+ (instancetype)nodeWithCode:(NSString *)code
{
    BinaryNode *node = [BinaryNode new];
    NSArray *bits = [code componentsSeparatedByString:@" "];
    for (NSInteger i = 0; i < [bits count]; i++) {
        if ([bits[i] isEqual:@"1"]) {
            node.nodeValue += 1 << i;
        }
    }
    return node;
}

- (BOOL)isEqual:(BinaryNode *)node
{
    return _nodeValue == node->_nodeValue;
}

- (NSArray *)nodeValuesWithDistance:(NSInteger)distance
{
    NSMutableArray *nearest = [NSMutableArray arrayWithObject:[BinaryNode nodeWithValue:_nodeValue]];
    for (NSInteger i = 0; i < 24; i++) {
        NSInteger shift = 1 << i;
        NSInteger nearestValue = _nodeValue ^ shift;
        [nearest addObject:[BinaryNode nodeWithValue:nearestValue]];
    }
    if (distance > 1) {
        NSMutableSet *nearestSet = [NSMutableSet new];
        NSMutableArray *allNearest = [NSMutableArray new];
        for (BinaryNode *node in nearest) {
            NSArray *nodeNearest = [node nodeValuesWithDistance:distance - 1];
            for (BinaryNode *nn in nodeNearest) {
                if (![nearestSet containsObject:@(nn.nodeValue)]) {
                    [allNearest addObject:nn];
                    [nearestSet addObject:@(nn.nodeValue)];
                }
            }
        }
        nearest = allNearest;
    }
    return nearest;
}

@end
