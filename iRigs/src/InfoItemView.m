//
//  InfoItemView.m
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "InfoItemView.h"

@interface InfoItemView () <IntroItemViewDelegate>

@property (nonatomic, strong) UIButton*    backBtn;
@property (nonatomic, strong) UIImageView* lineView;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel*     lbl;
@property (nonatomic, strong) UILabel*     introLbl;
@property (nonatomic, strong) UITextView*  textView;

@end

@implementation InfoItemView

- (instancetype) initWithFrame: (CGRect)    frame
                         title: (NSString*) title
                       andInfo: (NSString*) info
{
    self = [super initWithFrame: frame];
    if (self) {
        self.frame         = CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568);
        self.imgView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568)];
        self.imgView.image = [UIImage imageName: @"background"];
        [self addSubview: self.imgView];
        
        self.backBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60, 60)];
        [self.backBtn  setImage: [UIImage imageNamed: @"icon_menu_back"]];
        [self.backBtn addTarget: self action: @selector(backPressed) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.backBtn];
        
        self.lineView       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPAD ? 768 : 640, IPAD ? 2 : 1)];
        self.lineView.image = [UIImage imageNamed: @"separator"];
        [self addSubview: self.lineView];
        
        self.lbl               = [UILabel new];
        self.lbl.textAlignment = NSTextAlignmentCenter;
        self.lbl.textColor     = [UIColor whiteColor];
        self.lbl.font          = [UIFont dosisOfSize: 21];
        self.lbl.text          = currentItem;
        [self.lbl sizeToFit];
        [self addSubview: self.lbl];
        
        self.nextBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 139 * 1.8 : 139, IPAD ? 43.5 * 1.7 : 43.5)];
        [self.nextBtn setImage: [UIImage imageNamed: @"btn_next_norm"] forState: UIControlStateNormal];
        [self.nextBtn addTarget: self action: @selector(introNextPressed) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.nextBtn];
        
        self.introLbl               = [UILabel new];
        self.introLbl.textAlignment = NSTextAlignmentCenter;
        self.introLbl.textColor     = [UIColor colorWithRed: 15.0 / 255.0 green: 184.0/255.0 blue: 235.0 / 255.0 alpha: 1.0];
        self.introLbl.font          = [UIFont dosisOfSize: 22];
        self.introLbl.text          = @"Intro";
        [self.introLbl sizeToFit];
        [self addSubview: self.introLbl];
        
        self.textView                 = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width - 15, IPAD ? 700 : iPhone_4 ? 330 : 412)];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textAlignment   = NSTextAlignmentJustified;
        self.textView.textColor       = [UIColor whiteColor];
        self.textView.font            = [UIFont dosisOfSize: 16];
        self.textView.text            = info;
        self.textView.selectable      = NO;
        self.textView.editable        = NO;
        [self addSubview: self.textView];
        
        UISwipeGestureRecognizer* swipeNext = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(introNextPressed)];
        swipeNext.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer: swipeNext];
    
    
        UISwipeGestureRecognizer* swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(backPressed)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer: swipeLeft];
    }
    return self;
}
         
         
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.backBtn.center  = CGPointMake(self.frame.size.width - ( IPAD ? 40 : 20), IPAD ? 30 : 15);
    self.lineView.center = CGPointMake(self.frame.size.width/2, IPAD ? 65 : 30);
    self.lbl.center      = CGPointMake(self.frame.size.width/2, IPAD ? 30 : 15);
    self.nextBtn.center  = CGPointMake(self.frame.size.width/2, self.frame.size.height - (IPAD ? 40 * 1.7 : 40));
    self.introLbl.center = CGPointMake(self.frame.size.width/2, IPAD ? 130 : 65);
    self.textView.center = CGPointMake(self.frame.size.width/2, IPAD ? 530 : iPhone_4 ? 245 : 290);
}

- (void) backPressed
{
    [self removeFromSuperview];
    
}

- (void) introNextPressed
{
    if([self.delegate respondsToSelector: @selector(introNextPressed)])
        [self.delegate introNextPressed];
}

@end
