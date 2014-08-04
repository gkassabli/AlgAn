//
//  BinaryNode.h
//  AlgAn
//
//  Created by Georgiy on 7/20/14.
//  Copyright (c) 2014 GK. All rights reserved.
//

@interface BinaryNode : NSObject

@property (nonatomic) NSInteger nodeValue;

+ (instancetype)nodeWithValue:(NSInteger)value;
+ (instancetype)nodeWithCode:(NSString *)code;

- (NSArray *)nodeValuesWithDistance:(NSInteger)distance;

@end
