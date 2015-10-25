//
//  NSDictionary+Extensions.m
//  TrelloKit
//
//  Created by Scott Petit on 10/25/15.
//  Copyright © 2015 Scott Petit. All rights reserved.
//

#import "NSDictionary+Extensions.h"

@implementation NSDictionary (TrelloKit)

- (id)trello_safeObjectForKey:(id)key
{
    id object = self[key];
    if (object == [NSNull null])
    {
        object = nil;
    }
    
    return object;
}

- (id)trello_safeCopyForKey:(id)key
{
    id object = [self[key] copy];
    if (object == [NSNull null])
    {
        object = nil;
    }
    
    return object;
}

@end
