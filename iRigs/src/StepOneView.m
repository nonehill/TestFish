//
//  StepOneView.m
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "StepOneView.h"

@interface StepOneView () <StepOneViewDelegate>

@property (nonatomic, strong) UIImageView* backgroundView;
@property (nonatomic, strong) UIButton*    backBtn;
@property (nonatomic, strong) UIImageView* lineView;
@property (nonatomic, strong) UIImageView* itemImgView;
@property (nonatomic, strong) UIView* frameImg;
@property (nonatomic, strong) UISwipeGestureRecognizer* swipeNext;

@end

@implementation StepOneView


- (instancetype) initWithFrame: (CGRect)     frame
                         image: (UIImage*)   image
                          step: (NSUInteger) step
                       andInfo: (NSString*)  info
{
    self = [super initWithFrame: frame];
    if (self) {

        if (lastStep == NO) {
            self.swipeNext = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(nextPressed:)];
            self.swipeNext.direction = UISwipeGestureRecognizerDirectionLeft;
        }
        
        self.frame                = CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568);
        self.layer.masksToBounds  = YES;
        self.backgroundView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568)];
        self.backgroundView.image = [UIImage imageName: @"background"];
        [self addSubview: self.backgroundView];
        
        self.backBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60, 60)];
        [self.backBtn setImage: [UIImage imageNamed: @"icon_menu_back"]];
        [self.backBtn addTarget: self action: @selector(backStepPressed) forControlEvents: UIControlEventTouchUpInside];
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
        
        self.itemImgView                    = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 236 * 1.8 : 236, IPAD ? 236 * 1.8 : 236)];
        self.itemImgView.image              = image;
        self.itemImgView.layer.cornerRadius = self.itemImgView.frame.size.width/2;
        [self addSubview: self.itemImgView];
        
        self.frameImg       = [[UIView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 235 * 1.8 : 235, IPAD ? 235 * 1.8 : 235)];
        self.frameImg.layer.cornerRadius = self.frameImg.frame.size.width/2;
        self.frameImg.layer.borderColor  = [UIColor colorWithRed: 15.0 / 255.0 green: 184.0/255.0 blue: 235.0 / 255.0 alpha: 1.0].CGColor;
        self.frameImg.layer.borderWidth  = 2.f;
        [self addSubview: self.frameImg];
        
        self.textView                 = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width - 15, IPAD ? 235 : iPhone_4 ? 74 : 126)];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textAlignment   = NSTextAlignmentCenter;
        self.textView.textColor       = [UIColor whiteColor];
        self.textView.font            = [UIFont dosisOfSize: 18];
        self.textView.text            = info;
        self.textView.selectable      = NO;
        self.textView.editable        = NO;
        [self addSubview: self.textView];
        
        self.stepLbl               = [[UILabel alloc]initWithFrame: CGRectMake(0, 0, IPAD ? 130 : 65, 40)];
        self.stepLbl.textColor     = [UIColor colorWithRed: 15.0 / 255.0 green: 184.0/255.0 blue: 235.0 / 255.0 alpha: 1.0];
        self.stepLbl.textAlignment = NSTextAlignmentLeft;
        self.stepLbl.font          = [UIFont dosisOfSize: 22];
        self.stepLbl.text          = [NSString stringWithFormat: @"Step %li", step];
        [self addSubview: self.stepLbl];
        
        self.prevBtn        = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 139 * 1.7 : 139, IPAD ? 43.5 * 1.7 : 43.5)];
        [self.prevBtn setImage: [UIImage imageNamed: @"btn_previous_norm"] forState: UIControlStateNormal];
        [self.prevBtn addTarget: self action: @selector(previousPressed) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.prevBtn];
        
        self.prevBtn.hidden == YES ? self.nextBtn.hidden = NO : YES;
        self.nextBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 139 * 1.7 : 139, IPAD ? 43.5 * 1.7 : 43.5)];
        [self.nextBtn setImage: [UIImage imageNamed: @"btn_next_norm"] forState: UIControlStateNormal];
        [self.nextBtn addTarget: self action: @selector(nextPressed:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.nextBtn];
        
        if (self.prevBtn.hidden == NO) {
            UISwipeGestureRecognizer* swipePrev = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(previousPressed)];
            swipePrev.direction = UISwipeGestureRecognizerDirectionRight;
         //   [self addGestureRecognizer: swipePrev];
        }
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.backBtn.center     = CGPointMake(self.frame.size.width - (IPAD ? 40 : 20), IPAD ? 30 : 15);
    self.lineView.center    = CGPointMake(self.frame.size.width/2, IPAD ? 65 : 30);
    self.lbl.center         = CGPointMake(self.frame.size.width/2, IPAD ? 30 : 15);
    self.itemImgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - (IPAD ? 80 : iPhone_4 ? 30 : 55));
    self.frameImg.center    = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - (IPAD ? 80 : iPhone_4 ? 30 : 55));
    self.textView.center    = CGPointMake(self.frame.size.width/2, IPAD ? 785 : iPhone_4 ? 370 : 435);
    self.stepLbl.center     = CGPointMake(self.frame.size.width/2, IPAD ? 140 : 65);
    self.nextBtn.center     = self.prevBtn.hidden == YES ? CGPointMake(self.frame.size.width/2, self.frame.size.height - (IPAD ? 40 * 1.7 : 40)) : CGPointMake(self.frame.size.width - (IPAD ? 100 : 13) - self.nextBtn.frame.size.width / 2, self.frame.size.height - (IPAD ? 40 * 1.7 : 40));
    self.prevBtn.center     = self.nextBtn.hidden == YES ? CGPointMake(self.frame.size.width / 2, self.frame.size.height - (IPAD ? 40 * 1.7 : 40)) : CGPointMake((IPAD ? 100 : 15) + self.prevBtn.frame.size.width / 2, self.frame.size.height - (IPAD ? 40 * 1.7 : 40));
    
    if (self.prevBtn.hidden == true && self.nextBtn.hidden == true)
        self.textView.center = CGPointMake(self.frame.size.width/2, IPAD ? 830 : iPhone_4 ? 404 : IPAD ? 600 : 450);
    else
        self.textView.center = CGPointMake(self.frame.size.width/2, IPAD ? 785 : iPhone_4 ? 370 : 435);
}


#pragma mark StepOneViewDelegate

- (void) backStepPressed
{
    if ([self.delegate respondsToSelector: @selector(backStepPressed)])
        [self.delegate backStepPressed];
}

- (void)nextPressed: (UIButton*) sender
{
    if([self.delegate respondsToSelector: @selector(nextPressed:)])
        [self.delegate nextPressed: sender];
}

- (void) previousPressed
{
  //  [self performSelectorOnMainThread: @selector(removeFromSuperview) withObject:nil waitUntilDone:YES];
    if([self.delegate respondsToSelector: @selector(previousPressed)])
        [self.delegate previousPressed];
}

@end
