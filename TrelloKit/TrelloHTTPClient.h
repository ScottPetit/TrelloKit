//
//  TrelloHTTPClient.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

typedef void (^TrelloHTTPClientSuccess)(NSURLSessionDataTask *response, id responseObject);
typedef void (^TrelloHTTPClientFailure)(NSURLSessionDataTask *task, NSError *error);

@interface TrelloHTTPClient : AFHTTPSessionManager

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
- (void)putCardWithIdentifier:(NSString *)identifier updatedProperties:(NSDictionary *)properties success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure;

@end
