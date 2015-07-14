//
//  SettingsView.m
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "SettingsView.h"
#import "SettingsItemView.h"

@interface SettingsView () <SettingsItemViewDelegate>

@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UIImageView* lineView;
@property (nonatomic, strong) UIButton*    hideBtn;

@end

@implementation SettingsView

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.frame           = CGRectMake(0, 0, IPAD ? 256 : 150, IPAD ? 1024 : iPhone_4 ? 480 : 568);
        self.backgroundColor = [UIColor blueColor];
        self.imgView         = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 256 : 150, IPAD ? 1024 : iPhone_4 ? 480 : 568)];
        self.imgView.image   = [UIImage imageName: @"menu_back"];
        [self addSubview: self.imgView];
        
        self.hideBtn = [[UIButton alloc] initWithFrame: CGRectMake (0, 0, 60, 60)];
        [self.hideBtn  setImage: [UIImage imageNamed: @"icon_menu_back"]];
        [self.hideBtn addTarget: self action: @selector(hideMenu) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.hideBtn];
        
        self.lineView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 255 : 150, IPAD ? 2 : 1)];
        self.lineView.image = [UIImage imageNamed: @"menu_separator"];
        [self.imgView addSubview: self.lineView];
        
        NSArray* titleArray       = @[@"Rigs", @"Rate This App", @"Carp Apps", @"Contact Us"];
        NSArray* iconArray        = @[@"icon_rigs_norm", @"icon_rate_us_norm", @"icon_carp_apps_norm", @"icon_contact_us_norm"];
        NSArray* pressedIconArray = @[@"icon_rigs_sel", @"icon_tackle_box_sel", @"icon_carp_apps_sel", @"icon_contact_us_sel"];

        
        for (int i = 1; i < [titleArray count] + 1; i++) {
            SettingsItemView* hidView = [[SettingsItemView alloc] initWithFrame: IPAD ? CGRectMake(self.frame.size.width/2 - 70, 88 * i + 140 * (i - 1) , 144, 144) : CGRectMake(self.frame.size.width/2 - 40, 44 * i + (iPhone_4 ? 62 : 70) * (i - 1) , 77, 77)
                                                                          image: [UIImage imageNamed: [NSString stringWithFormat: @"%@", iconArray[i-1]]]
                                                                andPressedImage: [UIImage imageNamed: [NSString stringWithFormat: @"%@", pressedIconArray[i-1]]]
                                                                       andTitle: [NSString stringWithFormat: @"%@", titleArray[i-1]]
                                                                         andTag: i - 1];
            hidView.delegate = self;
            [self addSubview: hidView];
        }
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.lineView.center = CGPointMake(self.frame.size.width/2, IPAD ? 65 : 30);
    self.hideBtn.center  = CGPointMake(self.frame.size.width - (IPAD ? 50 : 25), IPAD ? 30 : 15);
}


- (void) hideMenu
{
    if ([self.delegate respondsToSelector: @selector(hideMenu)])
        [self.delegate hideMenu];
}

#pragma mark SettingsItemViewDelegate

- (void) settingsItemPressed: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(settingsItemPressed:)])
        [self.delegate settingsItemPressed: sender];
}

@end