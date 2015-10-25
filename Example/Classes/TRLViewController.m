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

@implementation TRLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.dataManager = [TrelloDataManager alloc] initWithTrelloHTTPClient:[[TrelloHTTPClient alloc] initWithAppKey:kTrelloAPIKey authToken:kAuthorizatedToken]];
    
    [self.dataManager openBoardsWithSuccess:^(NSHTTPURLResponse *response, NSArray *openBoards) {
        TRLBoard *board = [openBoards firstObject];
        
        [self.dataManager cardsDueTodayForBoard:board success:^(NSHTTPURLResponse *response, id responseObject) {
            for (TRLCard *card in responseObject)
            {
                TRLLabel *label = [card.labels firstObject];
                self.view.backgroundColor = label.color;
            }
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        NSLog(@"Failure with error - %@", error);
    }];
}

@end
