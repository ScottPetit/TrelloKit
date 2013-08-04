//
//  TRLLabel.h
//  TrelloKit
//
//  Created by Scott Petit on 8/3/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

@interface TRLLabel : NSObject

+ (instancetype)labelFromDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *name;

@end
