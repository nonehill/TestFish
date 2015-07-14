//
//  BaseView.m
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "BaseView.h"

@interface BaseView () <BaseViewDelegate>

@property (nonatomic, strong) UIButton*    hiddenMenuBtn;
@property (nonatomic, strong) UIImageView* lineView;

@end

@implementation BaseView

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.frame         = CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568);
        self.imgView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : 568)];
        self.imgView.image = [UIImage imageName: @"background"];
        [self addSubview: self.imgView];
        
        self.hiddenMenuBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60, 60)];
        [self.hiddenMenuBtn  setImage: [UIImage imageNamed: @"btn_menu_norm"]];
        [self.hiddenMenuBtn addTarget: self action: @selector(showHiddenMenu) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.hiddenMenuBtn];
        
        self.lineView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 640, IPAD ? 2 : 1)];
        self.lineView.image = [UIImage imageNamed: @"separator"];
        [self addSubview: self.lineView];
        
        self.lbl               = [UILabel new];
        self.lbl.textAlignment = NSTextAlignmentCenter;
        self.lbl.textColor     = [UIColor whiteColor];
        [self.lbl setFont: [UIFont dosisOfSize: 21]];
        [self.lbl sizeToFit];
        [self addSubview: self.lbl];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.hiddenMenuBtn.center = CGPointMake(self.frame.size.width - (IPAD ? 40 : 20), IPAD ? 30 : 15);
    self.lineView.center      = CGPointMake(self.frame.size.width/2, 30);
    self.lbl.center           = CGPointMake(self.frame.size.width/2, 15);
}

#pragma mark RigsMenuViewDelegate

- (void) showHiddenMenu
{
    if ([self.delegate respondsToSelector: @selector(showHiddenMenu)])
        [self.delegate showHiddenMenu];
}

@end
