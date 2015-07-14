//
//  RigsMenuView.h
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RigsMenuViewDelegate <NSObject>

- (void) showHiddenMenu;
- (void) menuItemPressed: (UIButton*) sender;

@end

@interface RigsMenuView : BaseView <RigsMenuViewDelegate, BaseViewDelegate>

@property (nonatomic, assign) id <RigsMenuViewDelegate, BaseViewDelegate> delegate;

@end
