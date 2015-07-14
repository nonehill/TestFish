//
//  RigsMenuItemView.m
//  iRigs
//
//  Created by Serg T on 30.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "RigsMenuItemView.h"

@interface RigsMenuItemView () <RigsMenuItemDelegate>

@property (nonatomic, strong) UIButton* imgBtn;
@property (nonatomic, strong) UILabel*  lbl;

@end

@implementation RigsMenuItemView

- (id) initWithFrame: (CGRect)     frame
               image: (UIImage*)   image
            andTitle: (NSString*)  title
              andTag: (NSUInteger) tag
{
    self = [super initWithFrame: frame];
    if (self) {
        self.imgBtn     = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 226 : 113, IPAD ? 226 : 113)];
        self.imgBtn.tag = tag;

        [self.imgBtn  setImage: image
                      forState: UIControlStateNormal];
        
        [self.imgBtn addTarget: self
                        action: @selector(menuItemPressed:)
              forControlEvents: UIControlEventTouchUpInside];
        
        [self addSubview: self.imgBtn];
        
        self.lbl                 = [UILabel new];
        self.lbl.backgroundColor = [UIColor clearColor];
        self.lbl.textAlignment   = NSTextAlignmentCenter;
        self.lbl.textColor       = [UIColor whiteColor];
        self.lbl.text            = title;
        [self.lbl setFont:[UIFont dosisOfSize: 18]];
        [self.lbl sizeToFit];
        [self addSubview: self.lbl];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lbl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height + (IPAD ? 35 : 13));
}

- (void) menuItemPressed: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(menuItemPressed:)])
        [self.delegate menuItemPressed: sender];
}

@end
