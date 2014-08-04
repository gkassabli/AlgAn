//
//  Job.m
//  AlgAn
//
//  Created by Georgiy on 7/12/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "Job.h"

@implementation Job

+ (NSArray *)readJobsFromFile:(NSString *)file
{
    NSMutableArray *jobs = [NSMutableArray new];
    
    NSString *fileText = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:file withExtension:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *jobStrings = [fileText componentsSeparatedByString:@"\n"];
    for (NSString *jobString in jobStrings) {
        NSArray *jobComponents = [jobString componentsSeparatedByString:@" "];
        if ([jobComponents count] == 2) {
            Job *newJob = [Job new];
            newJob.weigth = [jobComponents[0] integerValue];
            newJob.length = [jobComponents[1] integerValue];
            [jobs addObject:newJob];
        }
    }
    return jobs;
}

@end
