//
//  NSDictionary+Extensions.h
//  TrelloKit
//
//  Created by Scott Petit on 10/25/15.
//  Copyright © 2015 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TrelloKit)

- (id)trello_safeObjectForKey:(id)key;

- (id)trello_safeCopyForKey:(id)key;

@end
