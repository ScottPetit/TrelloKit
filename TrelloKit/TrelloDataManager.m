//
//  TrelloDataManager.m
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TrelloDataManager.h"
#import "TrelloHTTPClient.h"
#import "TRLBoard.h"
#import "TRLCard.h"
#import "TRLList.h"
#import "NSDate+MTDates.h"

@interface TrelloDataManager ()
@property (nonatomic, strong) TrelloHTTPClient *client;
@end

@implementation TrelloDataManager

- (instancetype)initWithTrelloHTTPClient:(TrelloHTTPClient *)client
{
    self = [super init];
    if (self) {
        self.client = client;
    }
    return self;
}

#pragma mark - Boards

- (void)boardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [self.client getBoardsWithSuccess:^(NSURLSessionDataTask *response, id responseObject) {
        
        NSMutableArray *boards = [NSMutableArray array];
        for (NSDictionary *boardsDictionary in responseObject)
        {
            TRLBoard *board = [TRLBoard boardFromDictionary:boardsDictionary];
            [boards addObject:board];
        }
        
        self.boards = boards;
        
        if (success)
        {
            success(response, boards);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)openBoardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [self.client getBoardsWithSuccess:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *boards = [NSMutableArray array];
        for (NSDictionary *boardsDictionary in responseObject)
        {
            TRLBoard *board = [TRLBoard boardFromDictionary:boardsDictionary];
            [boards addObject:board];
        }
        
        NSMutableArray *mutableBoards = [NSMutableArray arrayWithCapacity:boards.count];
        for (TRLBoard *board in boards)
        {
            if (!board.isClosed)
            {
                [mutableBoards addObject:board];
            }
        }
        
        self.openBoards = mutableBoards;
        
        if (success)
        {
            success(response, mutableBoards);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)boardWithIdentifer:(NSString *)identifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSAssert(identifier.length, @"Can not handle an identifier with no length");
    
    if (!identifier.length)
    {
        return;
    }
    
    [self.client getBoardWithIdentifer:identifier success:^(NSURLSessionDataTask *response, id responseObject) {
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

- (void)listsForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSAssert(board.identifier.length, @"Can not handle an identifier with no length");
    
    if (!board.identifier.length)
    {
        return;
    }
    
    [self.client getListsForBoardWithIdentifier:board.identifier success:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *lists = [NSMutableArray array];
        for (NSDictionary *listsDictionary in responseObject)
        {
            TRLList *list = [TRLList listWithDictionary:listsDictionary];
            [lists addObject:list];
        }
        
        if (success)
        {
            success(responseObject, lists);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)listsForBoardIdentifier:(NSString *)boardIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(boardIdentifier.length);
    
    [self.client getListsForBoardWithIdentifier:boardIdentifier success:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *lists = [NSMutableArray array];
        for (NSDictionary *listsDictionary in responseObject)
        {
            TRLList *list = [TRLList listWithDictionary:listsDictionary];
            [lists addObject:list];
        }
        
        if (success)
        {
            success(responseObject, lists);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

#pragma mark - Cards

- (void)cardsForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [self cardsForBoardIdentifier:board.identifier success:success failure:failure];
}

- (void)cardsForBoardIdentifier:(NSString *)boardIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(boardIdentifier);
    NSAssert(boardIdentifier.length, @"Can not handle a board identifer with no length");
    
    [self.client getCardsForBoardWithIdentifier:boardIdentifier success:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *cardsArray = [NSMutableArray array];
        for (NSDictionary *cardsDictionary in responseObject)
        {
            TRLCard *card = [TRLCard cardWithDictionary:cardsDictionary];
            [cardsArray addObject:card];
        }
        
        if (success)
        {
            success(responseObject, cardsArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)cardsDueTodayForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(board.identifier);
    
    if (!board.identifier)
    {
        return;
    }
    
    [self.client getCardsForBoardWithIdentifier:board.identifier success:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *cardsArray = [NSMutableArray array];
        for (NSDictionary *cardsDictionary in responseObject)
        {
            TRLCard *card = [TRLCard cardWithDictionary:cardsDictionary];
            [cardsArray addObject:card];
        }
        
        NSMutableArray *dueCards = [NSMutableArray arrayWithCapacity:cardsArray.count];
        for (TRLCard *card in cardsArray)
        {
            if ([card.dueDate mt_isWithinSameDay:[NSDate date]])
            {
                [dueCards addObject:card];
            }
        }
        
        if (success)
        {
            success(response, dueCards);
        }        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)cardsForList:(TRLList *)list success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [self cardsForListIdentifier:list.identifier success:success failure:failure];
}

- (void)cardsForListIdentifier:(NSString *)listIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(listIdentifier.length);
    
    if (!listIdentifier.length)
    {
        return;
    }
    
    [self.client getCardsForListWithIdentifier:listIdentifier success:^(NSURLSessionDataTask *response, id responseObject) {
        NSMutableArray *cards = [NSMutableArray array];
        for (NSDictionary *cardsDictionary in responseObject)
        {
            TRLCard *card = [TRLCard cardWithDictionary:cardsDictionary];
            [cards addObject:card];
        }
        
        if (success)
        {
            success(response, cards);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)cardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [self.client getCardsWithSuccess:^(NSURLSessionDataTask *response, id responseObject) {
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

- (void)cardWithIdentifier:(NSString *)identifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSAssert(identifier.length, @"Can not handle an identifier with no length");
    
    if (!identifier.length)
    {
        return;
    }
    
    [self.client getCardWithIdentifier:identifier success:^(NSURLSessionDataTask *response, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(task, error);
        }
    }];
}

- (void)updateCard:(TRLCard *)baseCard toBeLike:(TRLCard *)mutatedCard success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure {
    NSDictionary *changes = [mutatedCard updatedPropertiesWithBase:baseCard];
    [self.client putCardWithIdentifier:baseCard.identifier updatedProperties:changes success:^(NSURLSessionDataTask *response, id responseObject) {
        if (success != nil) {
            success(response, [[TRLCard alloc] initWithDictionary:responseObject]);
        }
    } failure:failure];
}


@end
