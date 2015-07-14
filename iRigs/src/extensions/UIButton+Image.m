//
//  UIButton+Image.m
//  iRigs
//
//  Created by Serg T on 14.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "UIButton+Image.h"

@implementation UIButton (Image)

- (void) setImage: (UIImage*) img
{
    CGSize newSize = CGSizeMake(20 * (IPAD ? 2 : 1), 20 * (IPAD ? 2 : 1));
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [img drawInRect: CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext ();
    [self setImage: newImage forState: UIControlStateNormal];
}

@end
