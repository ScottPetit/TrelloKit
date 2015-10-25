//
//  TRLViewController.m
//  TrelloKit
//
//  Created by Scott Petit on 8/2/13.
//  Copyright (c) 2013 Scott Petit. All rights reserved.
//

#import "TRLViewController.h"
#import "TrelloDataManager.h"
#import "TrelloHTTPClient.h"
#import "TRLBoard.h"
#import "TRLList.h"
#import "TRLCard.h"
#import "TRLLabel.h"

@interface TRLViewController ()
@property (nonatomic, strong) TrelloDataManager *dataManager;
@end

static NSString * const kTrelloAPIKey = @"";
static NSString * const kTrelloAuthToken = @"";

@implementation TRLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.dataManager = [[TrelloDataManager alloc] initWithTrelloHTTPClient:[[TrelloHTTPClient alloc] initWithAppKey:kTrelloAPIKey authToken:kTrelloAuthToken]];
    
    [self.dataManager openBoardsWithSuccess:^(NSURLSessionDataTask *response, NSArray *openBoards) {
        TRLBoard *board = [openBoards firstObject];
        
        [self.dataManager cardsDueTodayForBoard:board success:^(NSURLSessionDataTask *response, id responseObject) {
            for (TRLCard *card in responseObject)
            {
                TRLLabel *label = [card.labels firstObject];
                self.view.backgroundColor = label.color;
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end
