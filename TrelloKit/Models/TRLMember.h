//
//  TRLMember.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TRLMemberType){
    TRLMemberTypeUnknown,
    TRLMemberTypeNormal
};

typedef NS_ENUM(NSUInteger, TRLMemberStatus){
    TRLMemberStatusUnkown,
    TRLMemberStatusActive,
    TRLMemberStatusDisconnected
};

@interface TRLMember : NSObject

+ (instancetype)memberFromDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *avatarHash;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, assign, getter = isConfirmed) BOOL confirmed;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *initials;
@property (nonatomic, assign) TRLMemberType memberType;
@property (nonatomic, assign) TRLMemberStatus memberStatus;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatarSource;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gravatarHash;

@end
