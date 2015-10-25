//
//  UIColor+Extensions.m
//  TrelloKit
//
//  Created by Scott Petit on 10/25/15.
//  Copyright © 2015 Scott Petit. All rights reserved.
//

#import "UIColor+Extensions.h"

@implementation UIColor (TrelloKit)

+ (instancetype)trello_colorFromString:(NSString *)colorString
{
    if (!colorString.length)
    {
        return nil;
    }
    
    NSString *lowercaseColor = [colorString lowercaseString];
    NSString *color = [lowercaseColor stringByAppendingString:@"Color"];
    
    SEL colorSelector = NSSelectorFromString(color);
    
    if ([UIColor respondsToSelector:colorSelector])
    {
        return [UIColor performSelector:colorSelector];
    }
    else
    {
        return nil;
    }
}

@end
