//
//  UIFont+Dosis.m
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "UIFont+Dosis.h"

@implementation UIFont (Dosis)

+ (UIFont*) dosisOfSize: (CGFloat) size
{
    return [UIFont fontWithName: @"Dosis-Book" size: IPAD ? size * 2 : size];
}

@end
