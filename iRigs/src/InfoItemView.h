//
//  InfoItemView.h
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroItemViewDelegate <NSObject>

- (void) introNextPressed;

@end

@interface InfoItemView : UIView

@property (nonatomic, weak) id <IntroItemViewDelegate> delegate;
@property (nonatomic, strong) UIButton*    nextBtn;

- (instancetype) initWithFrame: (CGRect)    frame
                         title: (NSString*) title
                       andInfo: (NSString*) info;

@end
