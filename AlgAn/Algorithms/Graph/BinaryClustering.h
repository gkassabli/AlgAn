//
//  BinaryClustering.h
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@class BinaryGraph;

@interface BinaryClustering : NSObject

- (void)evaluateClusterization:(BinaryGraph *)graph distance:(NSInteger)distance completionHandler:(void (^)(NSInteger clusters))completionHandler;

@end
