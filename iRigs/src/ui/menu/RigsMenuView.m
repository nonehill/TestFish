//
//  RigsMenuView.m
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "RigsMenuView.h"
#import "RigsMenuItemView.h"

@interface RigsMenuView () <RigsMenuViewDelegate, RigsMenuItemDelegate>

@property (nonatomic, strong) UIButton*    hiddenMenuBtn;
@property (nonatomic, strong) UIImageView* lineView;
@property (nonatomic, strong) UILabel*     lbl;


@end

@implementation RigsMenuView

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.lbl.text = @"Rigs";
        [self.lbl sizeToFit];

        NSArray* imgArray   = @[@"icon_category_01", @"icon_category_02", @"icon_category_03", @"icon_category_04", @"icon_category_05", @"icon_category_06"];
        NSArray* titleArray = @[@"Rigs", @"Lead Systems", @"Knots", @"Hook Patterns", @"Leads", @"Extras"];
        
        for (int i = 1; i < [imgArray count] + 1; i++) {
            RigsMenuItemView* itemView = [[RigsMenuItemView alloc] initWithFrame: IPAD ? CGRectMake(i%2 == 1 ? 100 : 440, i == 3 || i == 4 ? 400 : i == 5 || i == 6 ? 710 : 90, 226, 226) : CGRectMake(i%2 == 1 ? 30 : 180, i == 3 || i == 4 ? iPhone_4 ? 195 : 228 : i == 5 || i == 6 ? iPhone_4 ? 340 : 410 : 48, 113, 113)
                                                                           image: [UIImage imageNamed: [NSString stringWithFormat: @"%@", imgArray[i-1]]]
                                                                        andTitle: [NSString stringWithFormat: @"%@", titleArray[i-1]]
                                                                          andTag: i - 1];
            itemView.delegate = self;
            [self addSubview: itemView];
        }
}
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.lineView.center = CGPointMake(self.frame.size.width/2, IPAD ? 65 : 30);
    self.lbl.center      = CGPointMake(self.frame.size.width/2, IPAD ? 30 : 15);
}

#pragma mark RigsMenuViewDelegate

- (void) menuItemPressed: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(menuItemPressed:)])
        [self.delegate menuItemPressed: sender];
}

- (void) showHiddenMenu
{
    if ([self.delegate respondsToSelector: @selector(showHiddenMenu)])
        [self.delegate showHiddenMenu];
}


@end
