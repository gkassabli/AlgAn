//
//  Node.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)init
{
    if (self = [super init]) {
        _edges = [NSMutableArray new];
    }
    return self;
}

@end
