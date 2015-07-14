//
//  BaseTableViewInfo.h
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewInfoDelegate <NSObject>

- (void) infoPressed: (UIButton*) sender;
- (void) showHiddenMenu;

@end

@interface BaseTableViewInfo : UIView
{
    NSArray* imageArr;
    NSArray* titleArr;
}

@property (nonatomic, weak) id <BaseTableViewInfoDelegate> delegate;

- (instancetype) initWithFrame: (CGRect)    frame
                    imageArray: (NSArray*)  imgArray
                    titleArray: (NSArray*)  titleArray
                      andTitle: (NSString*) title;

@end
