//
//  BaseTableViewCell.m
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell () <BaseTableViewCellDelegate>

@end

@implementation BaseTableViewCell

- (instancetype) initWithStyle: (UITableViewCellStyle) style
               reuseIdentifier: (NSString*)            reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.frame           = CGRectMake(0, 0, 320, 80);
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        self.lbl                 = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 300 : 150, 80)];
        self.lbl.backgroundColor = [UIColor clearColor];
        self.lbl.textColor       = [UIColor whiteColor];
        self.lbl.textAlignment   = NSTextAlignmentLeft;
        self.lbl.font            = [UIFont dosisOfSize: 17];
        self.lbl.numberOfLines   = 2;
        [self addSubview: self.lbl];
        
        self.arrowBtn        = [[UIButton alloc] initWithFrame: CGRectMake(0, 0,IPAD ? 37 * 1.8 : 37, IPAD ? 37 * 1.8 : 37)];
        [self.arrowBtn setImage: [UIImage imageNamed: @"btn_arrow"] forState: UIControlStateNormal];
        [self.arrowBtn addTarget: self action: @selector(infoPressed:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.arrowBtn];
      
        self.imgView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 116/(IPAD ? 1 : 1.8), 116/(IPAD ? 1 : 1.8))];
        self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
        self.imgView.layer.borderColor  = [UIColor colorWithRed: 15.0 / 255.0 green: 184.0/255.0 blue: 235.0 / 255.0 alpha: 1.0].CGColor;
        self.imgView.layer.borderWidth  = 2;
        self.imgView.layer.masksToBounds = YES;
        [self addSubview: self.imgView];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.arrowBtn.center = CGPointMake(self.frame.size.width - (IPAD ? 70 : 35), self.frame.size.height/2);
    self.lbl.center      = CGPointMake(self.frame.size.width/2 + 30, self.frame.size.height/2);
    self.imgView.center  = CGPointMake(IPAD ? 110 : 55, self.frame.size.height/2);

    
}

- (void) infoPressed: (UIButton*) sender
{
    [self.arrowBtn setImage: [UIImage imageNamed: @"btn_next_press"]  forState: UIControlStateHighlighted];
    if([self.delegate respondsToSelector: @selector(infoPressed:)])
        [self.delegate infoPressed: sender];
}


@end
