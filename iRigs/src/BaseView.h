//
//  BaseView.h
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewDelegate <NSObject>

- (void) showHiddenMenu;

@end

@interface BaseView : UIView <BaseViewDelegate>

@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel*     lbl;

@property (nonatomic, assign) id <BaseViewDelegate> delegate;

@end
