//
//  Clustering.h
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class Graph;

@interface Clustering : NSObject

@property (nonatomic) NSInteger maxClusters;

- (void)evaluateClusterization:(Graph *)graph completionHandler:(void (^)(NSArray *clusters, CGFloat spacing))completionHandler;

@end
