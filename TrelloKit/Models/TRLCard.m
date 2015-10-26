//
//  TRLCard.m
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLCard.h"
#import "NSDate+MTDates.h"
#import "NSDictionary+Extensions.h"
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
        _identifier = [dictionary trello_safeCopyForKey:@"id"];
        _name = [dictionary trello_safeCopyForKey:@"name"];
        _cardDescription = [dictionary trello_safeCopyForKey:@"desc"];
        _boardIdentifier = [dictionary trello_safeCopyForKey:@"idBoard"];
        _listIdentifier = [dictionary trello_safeCopyForKey:@"idList"];
        _closed = [dictionary[@"closed"] boolValue];
        _position = [dictionary[@"pos"] integerValue];
        _url = [[NSURL URLWithString:[dictionary trello_safeObjectForKey:@"url"]] copy];
        _memberIdentifiers = [dictionary trello_safeObjectForKey:@"idMembers"];
        
        NSArray *labelsArray = [dictionary trello_safeObjectForKey:@"labels"];
        NSMutableArray *mutableLabels = [NSMutableArray arrayWithCapacity:labelsArray.count];
        for (NSDictionary *labelsDictionary in labelsArray)
        {
            TRLLabel *label = [TRLLabel labelFromDictionary:labelsDictionary];
            [mutableLabels addObject:label];
        }
        _labels = mutableLabels;
        
        NSString *dueString = [dictionary trello_safeCopyForKey:@"due"];
        if (dueString)
        {
            NSString *newDueString = [dueString stringByReplacingCharactersInRange:NSMakeRange(dueString.length - 5, 5) withString:@""];
            _dueDate = [NSDate mt_dateFromISOString:newDueString];
        }
    }
    return self;
}

@end
