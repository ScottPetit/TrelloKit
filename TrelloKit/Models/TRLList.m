//
//  TRLList.m
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLList.h"

@implementation TRLList

+ (instancetype)listWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _identifier = [dictionary[@"id"] copy];
        _name = [dictionary[@"name"] copy];
        _closed = [dictionary[@"closed"] boolValue];
        _boardIdentifier = [dictionary[@"idBoard"] copy];
        _position = [dictionary[@"pos"] integerValue];
        _subscribed = [dictionary[@"subscribed"] boolValue];
    }
    return self;
}

@end
