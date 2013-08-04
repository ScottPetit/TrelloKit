//
//  TrelloHTTPClient.m
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TrelloHTTPClient.h"
#warning Remove this Import
#import "TrelloKitConstants.h"

#warning Add your api key and token here
//static NSString * const kTrelloAPIKey = @"";
//static NSString * const kTrelloAPIToken = @"";

@implementation TrelloHTTPClient

+ (instancetype)client
{
    static TrelloHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.trello.com/1/"];
        sharedClient = [[self alloc] initWithBaseURL:baseURL];
    });
    return sharedClient;
}

#pragma mark - Boards

- (void)getBoardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    [self GET:@"members/my/boards" parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)getBoardWithIdentifer:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"boards/%@", identifier];
    [self GET:path parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
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
    [self GET:path parameters:Nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - Cards

- (void)getCardsForBoardWithIdentifier:(NSString *)boardIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"boards/%@/cards", boardIdentifier];
    [self GET:path parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(responseObject, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)getCardsForListWithIdentifier:(NSString *)listIdentifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"lists/%@/cards", listIdentifier];
    [self GET:path parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)getCardsWithSuccess:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    [self GET:@"members/my/cards" parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)getCardWithIdentifier:(NSString *)identifier success:(TrelloHTTPClientSuccess)success failure:(TrelloHTTPClientFailure)failure
{
    NSString *path = [NSString stringWithFormat:@"cards/%@", identifier];
    [self GET:path parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        if (success)
        {
            success(response, responseObject);
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

#pragma mark - Overrides

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSParameterAssert(method);
    
    if (!path) {
        path = @"";
    }
    
    NSMutableDictionary *mutableParamaters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParamaters setObject:kTrelloAPIKey forKey:@"key"];
    [mutableParamaters setObject:kTrelloAPIToken forKey:@"token"];
    
    NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];
    [request setAllHTTPHeaderFields:[self.session.configuration HTTPAdditionalHeaders]];
    if (self.requestSerializer) {
        request = [[self.requestSerializer requestBySerializingRequest:request withParameters:mutableParamaters error:nil] mutableCopy];
    }
    
	return request;
}

@end
