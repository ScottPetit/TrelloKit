//
//  TRLList.h
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLList : NSObject

+ (instancetype)listWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign, getter = isClosed) BOOL closed;
@property (nonatomic, copy) NSString *boardIdentifier;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, assign, getter = isSubscribed) BOOL subscribed;
@property (nonatomic, strong) NSArray *lists;

@end
