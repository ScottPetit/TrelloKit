//
//  TRLDataManagerTests.m
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrelloDataManager.h"

@interface TRLDataManagerTests : XCTestCase

@property (nonatomic, strong) TrelloDataManager *dataManager;

@end

@implementation TRLDataManagerTests

- (void)setUp
{
    [super setUp];
    
    self.dataManager = [TrelloDataManager manager];
}

- (void)testThatBoardsThrowsWithoutAnIdentifier
{
    XCTAssertThrows([self.dataManager boardWithIdentifer:nil success:nil failure:nil], @"Boards should throw when identifier is nil");
    
    XCTAssertThrows([self.dataManager boardWithIdentifer:@"" success:nil failure:nil], @"Boards should throw when the identifer is empty");
}

- (void)testThatListsThrowsWithoutAnIdentifier
{
    XCTAssertThrows([self.dataManager listsForBoard:nil success:nil failure:nil], @"Lists should throw when identifier is nil");
    
    XCTAssertThrows([self.dataManager listsForBoardIdentifier:@"" success:nil failure:nil], @"Lists should throw when identifier is empty");
}

- (void)testThatCardsThrowsWithoutAnIdentifier
{
    XCTAssertThrows([self.dataManager cardWithIdentifier:nil success:nil failure:nil], @"Cards should throw when identifier is nil");
    
    XCTAssertThrows([self.dataManager cardWithIdentifier:@"" success:nil failure:nil], @"Cards should throw when the identifier is empty");
}

@end
