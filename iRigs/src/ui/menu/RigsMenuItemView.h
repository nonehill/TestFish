//
//  RigsMenuItemView.h
//  iRigs
//
//  Created by Serg T on 30.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RigsMenuItemDelegate <NSObject>

- (void) menuItemPressed: (UIButton*) sender;

@end

@interface RigsMenuItemView : UIView

@property (nonatomic, weak) id <RigsMenuItemDelegate> delegate;

- (id) initWithFrame: (CGRect)    frame
               image: (UIImage*)  image
            andTitle: (NSString*) title
              andTag: (NSUInteger) tag;


@end
