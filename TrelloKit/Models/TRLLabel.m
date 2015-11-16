//
//  TRLLabel.m
//  TrelloKit
//
//  Created by Scott Petit on 8/3/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLLabel.h"
#import "NSDictionary+Extensions.h"
#import "UIColor+Extensions.h"

@implementation TRLLabel

+ (instancetype)labelFromDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _color = [UIColor trello_colorFromString:[dictionary trello_safeObjectForKey:@"color"]];
        _name = [dictionary trello_safeCopyForKey:@"name"];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    TRLLabel *result = [[[self class] alloc] init];
    result.color = self.color;
    result.name = self.name;
    return result;
}

@end
