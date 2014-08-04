//
//  BinaryGraph.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@interface BinaryGraph : NSObject

@property (nonatomic, strong) NSMutableArray *nodes;

+ (instancetype)readGraphFromFile:(NSString *)file;

@end
