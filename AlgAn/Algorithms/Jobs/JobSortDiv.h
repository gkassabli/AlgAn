//
//  JobSortDiv.h
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@interface JobSortDiv : NSObject

- (void)evaluateJobs:(NSArray *)jobs completionHandler:(void (^)(NSArray *sortedJobs, double_t completionCriteria))completionHandler;

@end
