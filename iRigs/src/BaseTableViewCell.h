//
//  BaseTableViewCell.h
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewCellDelegate <NSObject>

- (void) infoPressed: (UIButton*) sender;

@end

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UILabel*     lbl;

@property (nonatomic, weak) id <BaseTableViewCellDelegate> delegate;
@property (nonatomic, strong) UIButton* arrowBtn;
@end
