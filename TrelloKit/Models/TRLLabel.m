//
//  TRLLabel.m
//  TrelloKit
//
//  Created by Scott Petit on 8/3/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLLabel.h"
#import "NSDictionary+XOAdditions.h"
#import "UIColor+XOAdditions.h"

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
        _color = [UIColor xo_colorFromString:[dictionary xo_safeObjectForKey:@"color"]];
        _name = [dictionary xo_safeCopyForKey:@"name"];
    }
    return self;
}

@end
