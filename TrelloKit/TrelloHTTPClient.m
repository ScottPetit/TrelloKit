//
//  TrelloHTTPClient.m
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TrelloHTTPClient.h"

@interface TrelloHTTPClient ()
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *authToken;
@end

@interface AFHTTPSessionManager ()
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@implementation TrelloHTTPClient

- (instancetype)initWithAppKey:(NSString *)appKey authToken:(NSString *)token
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"https://api.trello.com/1/"]];
    if (self) {
        self.appKey = appKey;
        self.authToken = token;
    }
    return self;
}

#pragma mark - Boards

- (void)getBoardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    [self GET:@"members/my/boards" parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)getBoardWithIdentifer:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"boards/%@", identifier];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

#pragma mark - Lists

- (void)getListsForBoardWithIdentifier:(NSString *)boardIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSParameterAssert(boardIdentifier.length);
    
    if (!boardIdentifier.length)
    {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"boards/%@/lists", boardIdentifier];
    [self GET:path parameters:Nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

#pragma mark - Cards

- (void)getCardsForBoardWithIdentifier:(NSString *)boardIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"boards/%@/cards", boardIdentifier];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(responseObject, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)getCardsForListWithIdentifier:(NSString *)listIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"lists/%@/cards", listIdentifier];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)getCardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    [self GET:@"members/my/cards" parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)getCardWithIdentifier:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"cards/%@", identifier];
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)putCardWithIdentifier:(NSString *)identifier updatedProperties:(NSDictionary *)properties success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure {
    NSString *path = [NSString stringWithFormat:@"cards/%@", identifier];
    [self PUT:path parameters:properties success:success failure:failure];
}

#pragma mark - Overrides

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    NSMutableDictionary *mutableParamaters = [parameters isKindOfClass:[NSDictionary class]] ? [parameters mutableCopy] : [NSMutableDictionary dictionaryWithCapacity:2];
    mutableParamaters[@"key"] = self.appKey;
    mutableParamaters[@"token"] = self.authToken;
    return [super dataTaskWithHTTPMethod:method URLString:URLString parameters:mutableParamaters success:success failure:failure];
}

@end
