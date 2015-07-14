//
//  UIImage+Resizing.m
//  iRigs
//
//  Created by Serg T on 16.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "UIImage+Resizing.h"

@implementation UIImage (Resizing)

 + (UIImage*) imageName: (NSString*) name
{
    return [UIImage imageNamed: [NSString stringWithFormat:@"%@%@", name, (IPAD ? @"@2x" : @"")]];
}

@end
