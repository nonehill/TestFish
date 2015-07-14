//
//  StepOneView.h
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StepOneViewDelegate <NSObject>

- (void) backStepPressed;

@optional

- (void) nextPressed: (UIButton*) sender;
- (void) previousPressed;

@end

@interface StepOneView : UIView

@property (nonatomic, strong) UIButton*    prevBtn;
@property (nonatomic, strong) UIButton*    nextBtn;
@property (nonatomic, strong) UITextView*  textView;

@property (nonatomic, strong) UILabel*     stepLbl;
@property (nonatomic, strong) UILabel*     lbl;

@property (nonatomic, assign) id <StepOneViewDelegate> delegate;

- (instancetype) initWithFrame: (CGRect)     frame
                         image: (UIImage*)   image
                          step: (NSUInteger) step
                       andInfo: (NSString*)  info;

@end
