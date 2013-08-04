//
//  TRLBoard.m
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLBoard.h"

@implementation TRLBoard

+ (instancetype)boardFromDictionary:(NSDictionary *)dictionary
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
        _boardDescription = [dictionary[@"desc"] copy];
        _closed = [dictionary[@"closed"] boolValue];
        _organizationIdentifier = [dictionary[@"idOrganization"] copy];
        _pinned = [dictionary[@"pinned"] boolValue];
        _url = [[NSURL URLWithString:dictionary[@"url"]] copy];
    }
    return self;
}

@end
