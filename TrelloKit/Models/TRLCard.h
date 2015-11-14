//
//  TRLCard.h
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLCard : NSObject <NSCopying>

+ (instancetype)cardWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cardDescription;
@property (nonatomic, copy) NSString *boardIdentifier;
@property (nonatomic, copy) NSString *listIdentifier;
@property (nonatomic, assign, getter = isClosed) BOOL closed;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, strong) NSArray *memberIdentifiers;

@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) NSArray *labels;

@end
