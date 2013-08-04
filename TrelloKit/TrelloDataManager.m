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

@implementation TrelloDataManager

+ (instancetype)manager
{
    static TrelloDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - Boards

- (void)boardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [[TrelloHTTPClient client] getBoardsWithSuccess:^(NSHTTPURLResponse *response, id responseObject) {
        
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
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)openBoardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [[TrelloHTTPClient client] getBoardsWithSuccess:^(NSHTTPURLResponse *response, id responseObject) {
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
        
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
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
    
    [[TrelloHTTPClient client] getBoardWithIdentifer:identifier success:^(NSHTTPURLResponse *response, id responseObject) {
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

- (void)listsForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSAssert(board.identifier.length, @"Can not handle an identifier with no length");
    
    if (!board.identifier.length)
    {
        return;
    }
    
    [[TrelloHTTPClient client] getListsForBoardWithIdentifier:board.identifier success:^(NSHTTPURLResponse *response, id responseObject) {
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
    } failure:^(NSError *error) {
        
    }];
}

- (void)listsForBoardIdentifier:(NSString *)boardIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(boardIdentifier.length);
    
    [[TrelloHTTPClient client] getListsForBoardWithIdentifier:boardIdentifier success:^(NSHTTPURLResponse *response, id responseObject) {
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
    } failure:^(NSError *error) {
        
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
    
    [[TrelloHTTPClient client] getCardsForBoardWithIdentifier:boardIdentifier success:^(NSHTTPURLResponse *response, id responseObject) {
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
    } failure:^(NSError *error) {
        
    }];
}

- (void)cardsDueTodayForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSParameterAssert(board.identifier);
    
    if (!board.identifier)
    {
        return;
    }
    
    [[TrelloHTTPClient client] getCardsForBoardWithIdentifier:board.identifier success:^(NSHTTPURLResponse *response, id responseObject) {
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
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
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
    
    [[TrelloHTTPClient client] getCardsForListWithIdentifier:listIdentifier success:^(NSHTTPURLResponse *response, id responseObject) {
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
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
}

- (void)cardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    [[TrelloHTTPClient client] getCardsWithSuccess:^(NSHTTPURLResponse *response, id responseObject) {
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

- (void)cardWithIdentifier:(NSString *)identifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure
{
    NSAssert(identifier.length, @"Can not handle an identifier with no length");
    
    if (!identifier.length)
    {
        return;
    }
    
    [[TrelloHTTPClient client] getCardWithIdentifier:identifier success:^(NSHTTPURLResponse *response, id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
