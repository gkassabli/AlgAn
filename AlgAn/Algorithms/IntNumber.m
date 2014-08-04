//
//  IntValue.m
//  AlgAn
//
//  Created by Georgiy on 8/3/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

#import "IntNumber.h"

@implementation IntNumber

- (instancetype)init
{
    if (self = [super init]) {
        _value = 0;
    }
    return self;
}

- (NSString *)description
{
    return [@(_value) stringValue];
}

@end

@implementation FloatNumber

- (instancetype)init
{
    if (self = [super init]) {
        _value = 0.0;
    }
    return self;
}

- (NSString *)description
{
    return [@(_value) stringValue];
}

@end

