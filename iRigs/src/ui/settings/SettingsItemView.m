//
//  SettingsItemView.m
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "SettingsItemView.h"

@interface SettingsItemView () <SettingsItemViewDelegate>

@property (nonatomic, strong) UILabel* lbl;

@end

@implementation SettingsItemView

- (id) initWithFrame: (CGRect)     frame
               image: (UIImage*)   image
     andPressedImage: (UIImage*)   pressedImage
            andTitle: (NSString*)  title
              andTag: (NSUInteger) tag
{
    self = [super initWithFrame: frame];
    if (self) {
        imgBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 144 : 77, IPAD ? 144 : 77)];
        [imgBtn setImage: image        forState: UIControlStateNormal];
        [imgBtn setImage: pressedImage forState: UIControlStateSelected];
        [imgBtn addTarget: self action: @selector(settingsItemPressed:) forControlEvents: UIControlEventTouchUpInside];
        imgBtn.tag = tag;
        [self addSubview: imgBtn];
        
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
    self.lbl.center = CGPointMake(self.frame.size.width/2, self.frame.size.height + (IPAD ? 26 : 13));
}

- (void) settingsItemPressed: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(settingsItemPressed:)])
        [self.delegate settingsItemPressed: sender];
}


@end
