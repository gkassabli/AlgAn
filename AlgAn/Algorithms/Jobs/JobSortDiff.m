//
//  JobSortDiff.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "JobSortDiff.h"

#import "Job.h"

@implementation JobSortDiff

- (void)evaluateJobs:(NSArray *)jobs completionHandler:(void (^)(NSArray *sortedJobs, double_t completionCriteria))completionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *sortedJobs = [jobs sortedArrayUsingComparator:^NSComparisonResult(Job *job1, Job *job2) {
            NSInteger diff1 = job1.weigth - job1.length;
            NSInteger diff2 = job2.weigth - job2.length;
            if (diff1 > diff2) {
                return NSOrderedAscending;
            } else if (diff2 > diff1) {
                return NSOrderedDescending;
            } else {
                return job1.weigth > job2.weigth ? NSOrderedAscending : NSOrderedDescending;
            }
        }];
        CGFloat runningTime = 0;
        double_t completionCriteria = 0;
        for (Job *job in sortedJobs) {
            runningTime += job.length;
            job.completionTime = runningTime;
            completionCriteria += job.weigth * job.completionTime;
//            NSLog(@"%10f", completionCriteria);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(sortedJobs, completionCriteria);
        });
    });
}

@end
