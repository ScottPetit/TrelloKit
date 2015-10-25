//
//  TrelloHTTPClient.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^TrelloHTTPClientSuccess)(NSHTTPURLResponse *response, id responseObject);
typedef void (^TrelloHTTPClientFailure)(NSError *error);

@interface TrelloHTTPClient : AFHTTPClient

- (instancetype)initWithAppKey:(NSString *)appKey authToken:(NSString *)token;

//Boards
- (void)getBoardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;
- (void)getBoardWithIdentifer:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;

//Lists
- (void)getListsForBoardWithIdentifier:(NSString *)boardIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;

//Boards
- (void)getCardsForBoardWithIdentifier:(NSString *)boardIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;
- (void)getCardsForListWithIdentifier:(NSString *)listIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;
- (void)getCardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;
- (void)getCardWithIdentifier:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;

@end
