//
//  Edge.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class Node;

@interface Edge : NSObject

@property (nonatomic, weak) Node *node1;
@property (nonatomic, weak) Node *node2;
@property (nonatomic) NSInteger length;

@end
