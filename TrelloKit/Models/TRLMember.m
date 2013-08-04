//
//  TRLMember.m
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLMember.h"

@implementation TRLMember

+ (instancetype)memberFromDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _identifier = [dictionary[@"id"] copy];
        _avatarHash = [dictionary[@"avatarHash"] copy];
        _bio = [dictionary[@"bio"] copy];
        _confirmed = [dictionary[@"confirmed"] boolValue];
        _fullName = [dictionary[@"fullName"] copy];
        _initials = [dictionary[@"initials"] copy];
        _memberType = [self memberTypeForString:dictionary[@"memberType"]];
        _memberStatus = [self memberStatusForString:dictionary[@"memberStatus"]];
        _username = [dictionary[@"username"] copy];
        _avatarSource = [dictionary[@"avatarSource"] copy];
        _email = [dictionary[@"email"] copy];
        _gravatarHash = [dictionary[@"gravatarHash"] copy];
    }
    return self;
}

- (TRLMemberType)memberTypeForString:(NSString *)string
{
    if ([string isEqualToString:@"normal"])
    {
        return TRLMemberTypeNormal;
    }
    else
    {
        return TRLMemberTypeUnknown;
    }
}

- (TRLMemberStatus)memberStatusForString:(NSString *)string
{
    if ([string isEqualToString:@"active"])
    {
        return TRLMemberStatusActive;
    }
    else if ([string isEqualToString:@"disconnected"])
    {
        return TRLMemberStatusDisconnected;
    }
    else
    {
        return TRLMemberStatusUnkown;
    }
}

@end
