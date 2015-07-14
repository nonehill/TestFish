//
//  SettingsView.h
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewDelegate <NSObject>

- (void) hideMenu;
- (void) settingsItemPressed: (UIButton*) sender;

@end

@interface SettingsView : UIView <SettingsViewDelegate>

@property (nonatomic, weak) id <SettingsViewDelegate> delegate;

@end
