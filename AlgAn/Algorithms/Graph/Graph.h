//
//  Graph.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@interface Graph : NSObject

@property (nonatomic, strong) NSMutableArray *nodes;
@property (nonatomic, strong) NSMutableSet *edges;
@property (nonatomic, readonly) BOOL directed;

+ (instancetype)readGraphFromFile:(NSString *)file;
+ (instancetype)readDirectedGraphFromFile:(NSString *)file;

@end
