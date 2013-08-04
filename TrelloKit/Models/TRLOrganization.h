//
//  TRLOrganization.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLOrganization : NSObject

+ (instancetype)organizationFromDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *organizationDescription;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *website;
@property (nonatomic, copy) NSString *logoHash;

@end
