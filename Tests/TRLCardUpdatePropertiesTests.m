//
//  TRLCardUpdatePropertiesTests.m
//  TrelloKit
//
//  Created by sbuglakov on 14/11/15.
//  Copyright (c) 2015 Scott Petit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRLCard.h"

@interface TRLCardUpdatePropertiesTests : XCTestCase
@property (nonatomic, strong) TRLCard *baseCard;
@property (nonatomic, strong) TRLCard *mutatedCard;
@end

@implementation TRLCardUpdatePropertiesTests

- (void)setUp {
    [super setUp];
    
    self.baseCard = [[TRLCard alloc] initWithDictionary:@{
        @"due": [NSNull null],
        @"closed": @0,
        @"desc": @"",
        @"idBoard": @"boardNumber",
        @"idList": @"listNumber",
        @"idMembers": @[@"memberA"],
        @"pos": @1,
        @"id": @123,
        @"subscribed": @YES,
    }];
    
    self.mutatedCard = [self.baseCard copy];
}

- (void)testListAndMembersFields {
    self.mutatedCard.listIdentifier = @"newListNumber";
    self.mutatedCard.memberIdentifiers = [self.mutatedCard.memberIdentifiers arrayByAddingObject:@"newMember"];
    NSDictionary *changes = [self.mutatedCard updatedPropertiesWithBase:self.baseCard];
    NSDictionary *etalon = @{@"idList": @"newListNumber", @"idMembers": @"memberA,newMember"};
    XCTAssertEqualObjects(changes, etalon);
}

- (void)testSubscribed {
    self.mutatedCard.subscribed = NO;
    NSDictionary *changes = [self.mutatedCard updatedPropertiesWithBase:self.baseCard];
    NSDictionary *etalon = @{@"subscribed": @NO};
    XCTAssertEqualObjects(changes, etalon);
}

@end
