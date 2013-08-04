//
//  TRLBoard.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLBoard : NSObject

+ (instancetype)boardFromDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *boardDescription;
@property (nonatomic, assign, getter = isClosed) BOOL closed;
@property (nonatomic, copy) NSString *organizationIdentifier;
@property (nonatomic, assign, getter = isPinned) BOOL pinned;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, strong) NSArray *lists;

@end
