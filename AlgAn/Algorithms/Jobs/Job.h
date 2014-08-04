//
//  Job.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@interface Job : NSObject

+ (NSArray *)readJobsFromFile:(NSString *)file;

@property (nonatomic) NSInteger weigth;
@property (nonatomic) NSInteger length;
@property (nonatomic) NSInteger completionTime;

@end
