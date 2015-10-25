//
//  UIColor+Extensions.h
//  TrelloKit
//
//  Created by Scott Petit on 10/25/15.
//  Copyright © 2015 Scott Petit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TrelloKit)

+ (instancetype)trello_colorFromString:(NSString *)colorString;

@end
