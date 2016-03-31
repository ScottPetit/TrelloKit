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

static NSDictionary *copyBindings;

@implementation TRLCard

+ (void)initialize {
    copyBindings = @{
                     @"identifier": @"id",
                     @"name": @"name",
                     @"cardDescription": @"desc",
                     @"listIdentifier": @"idList",
                     @"boardIdentifier": @"idBoard",
    };
}

+ (instancetype)cardWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        [copyBindings enumerateKeysAndObjectsUsingBlock:^(id selfKey, id trelloKey, BOOL *stop) {
            id value = [dictionary trello_safeCopyForKey:trelloKey];
            [self setValue:value forKey:selfKey];
        }];
        _closed = [dictionary[@"closed"] boolValue];
        _subscribed = [dictionary[@"subscribed"] boolValue];
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

- (id)copyWithZone:(NSZone *)zone {
    TRLCard *result = [[[self class] allocWithZone:zone] init];
    result.identifier = self.identifier;
    result.name = self.name;
    result.boardIdentifier = self.boardIdentifier;
    result.cardDescription = self.cardDescription;
    result.listIdentifier = self.listIdentifier;
    result.closed = self.isClosed;
    result.subscribed = self.isSubscribed;
    result.position = self.position;
    result.dueDate = self.dueDate;
    result.url = self.url;
    result.memberIdentifiers = [self.memberIdentifiers copyWithZone:zone];
    result.members = [self.members copyWithZone:zone];
    result.labels = [self.labels copyWithZone:zone];
    return result;
}

- (NSDictionary *)updatedPropertiesWithBase:(TRLCard *)baseCard {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [copyBindings enumerateKeysAndObjectsUsingBlock:^(NSString *selfKey, id trelloKey, BOOL *stop) {
        id newValue = [self valueForKey:selfKey];
        id oldValue = [baseCard valueForKey:selfKey];
        if ((newValue != nil && ![newValue isEqual:oldValue]) || (newValue == nil && oldValue != nil)) {
            result[trelloKey] = newValue ?: [NSNull null];
        }
    }];
    
    if (self.isSubscribed != baseCard.isSubscribed) {
        result[@"subscribed"] = @(self.isSubscribed);
    }

    if (![[NSSet setWithArray:self.memberIdentifiers] isEqual:[NSSet setWithArray:baseCard.memberIdentifiers]]) {
        result[@"idMembers"] = [self.memberIdentifiers componentsJoinedByString:@","];
    }
    
    if ((self.dueDate != nil && ![self.dueDate isEqual:baseCard.dueDate]) || (self.dueDate == nil && baseCard.dueDate != nil)) {
        result[@"due"] = [self.dueDate mt_stringFromDateWithISODateTime] ?: [NSNull null];
    }
    
    return result;
}

@end
