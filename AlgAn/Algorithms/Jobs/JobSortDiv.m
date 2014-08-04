//
//  JobSortDiv.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "JobSortDiv.h"

#import "Job.h"

@implementation JobSortDiv

- (void)evaluateJobs:(NSArray *)jobs completionHandler:(void (^)(NSArray *sortedJobs, double_t completionCriteria))completionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *sortedJobs = [jobs sortedArrayUsingComparator:^NSComparisonResult(Job *job1, Job *job2) {
            CGFloat div1 = (CGFloat)job1.weigth / job1.length;
            CGFloat div2 = (CGFloat)job2.weigth / job2.length;
            if (div1 > div2) {
                return NSOrderedAscending;
            } else if (div2 > div1) {
                return NSOrderedDescending;
            } else {
                return job1.weigth > job2.weigth ? NSOrderedAscending : NSOrderedDescending;
            }
        }];
        CGFloat runningTime = 0;
        double completionCriteria = 0;
        for (Job *job in sortedJobs) {
            runningTime += job.length;
            job.completionTime = runningTime;
            completionCriteria += job.weigth * job.completionTime;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(sortedJobs, completionCriteria);
        });
    });
}

@end
