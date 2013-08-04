//
//  TrelloDataManager.h
//  TrelloKit
//
//  Created by Scott Petit on 7/27/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRLBoard;
@class TRLList;

typedef void (^TrelloDataManagerSuccess)(NSHTTPURLResponse *response, id responseObject);
typedef void (^TrelloDataManagerFailure)(NSError *error);

@interface TrelloDataManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong) NSArray *boards;
@property (nonatomic, strong) NSArray *openBoards;

//Boards
- (void)boardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)openBoardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)boardWithIdentifer:(NSString *)identifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;

//Lists
- (void)listsForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)listsForBoardIdentifier:(NSString *)boardIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;

//Cards
- (void)cardsForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardsForBoardIdentifier:(NSString *)boardIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardsDueTodayForBoard:(TRLBoard *)board success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardsForList:(TRLList *)list success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardsForListIdentifier:(NSString *)listIdentifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardsWithSuccess:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;
- (void)cardWithIdentifier:(NSString *)identifier success:(TrelloDataManagerSuccess)success failure:(TrelloDataManagerFailure)failure;

@end
