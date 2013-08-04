//
//  TRLCard.m
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLCard.h"
#import "NSDate+MTDates.h"
#import "NSDictionary+XOAdditions.h"
#import "TRLLabel.h"

@implementation TRLCard

+ (instancetype)cardWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _identifier = [dictionary xo_safeCopyForKey:@"id"];
        _name = [dictionary xo_safeCopyForKey:@"name"];
        _cardDescription = [dictionary xo_safeCopyForKey:@"desc"];
        _boardIdentifier = [dictionary xo_safeCopyForKey:@"idBoard"];
        _listIdentifier = [dictionary xo_safeCopyForKey:@"idList"];
        _closed = [dictionary[@"closed"] boolValue];
        _position = [dictionary[@"pos"] integerValue];
        _url = [[NSURL URLWithString:[dictionary xo_safeObjectForKey:@"url"]] copy];
        _memberIdentifiers = [dictionary xo_safeObjectForKey:@"members"];
        
        NSArray *labelsArray = [dictionary xo_safeObjectForKey:@"labels"];
        NSMutableArray *mutableLabels = [NSMutableArray arrayWithCapacity:labelsArray.count];
        for (NSDictionary *labelsDictionary in labelsArray)
        {
            TRLLabel *label = [TRLLabel labelFromDictionary:labelsDictionary];
            [mutableLabels addObject:label];
        }
        _labels = mutableLabels;
        
        NSString *dueString = [dictionary xo_safeCopyForKey:@"due"];
        if (dueString)
        {
            NSString *newDueString = [dueString stringByReplacingCharactersInRange:NSMakeRange(dueString.length - 5, 5) withString:@""];
            _dueDate = [NSDate mt_dateFromISOString:newDueString];
        }
    }
    return self;
}

@end
