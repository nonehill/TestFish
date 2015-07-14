//
//  SettingsItemView.h
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsItemViewDelegate <NSObject>

- (void) settingsItemPressed: (UIButton*) sender;

@end

@interface SettingsItemView : UIView
{
    UIButton* imgBtn;
}

@property (nonatomic, weak) id <SettingsItemViewDelegate> delegate;

- (id) initWithFrame: (CGRect)frame image: (UIImage*) image andPressedImage: (UIImage*) pressedImage andTitle: (NSString*) title andTag: (NSUInteger) tag;

@end
