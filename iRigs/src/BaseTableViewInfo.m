//
//  BaseTableViewInfo.m
//  iRigs
//
//  Created by Serg on 02.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "BaseTableViewInfo.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewInfo () <UITableViewDataSource, UITableViewDelegate, BaseTableViewInfoDelegate, BaseTableViewCellDelegate>

@property (nonatomic, strong) UIButton*    hiddenMenuBtn;
@property (nonatomic, strong) UIImageView* lineView;
@property (nonatomic, strong) UILabel*     lbl;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation BaseTableViewInfo

- (instancetype) initWithFrame: (CGRect)    frame
                    imageArray: (NSArray*)  imgArray
                    titleArray: (NSArray*)  titleArray
                      andTitle: (NSString*) title
{
    self = [super initWithFrame: frame];
    if (self) {
        imageArr = imgArray;
        titleArr = titleArray;
        
        self.frame         = CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568);
        self.imgView       = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568)];
        self.imgView.image = [UIImage imageName: @"background"];
        [self addSubview: self.imgView];
        
        self.hiddenMenuBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60, 60)];
        [self.hiddenMenuBtn  setImage: [UIImage imageNamed: @"icon_menu_back"]];
        [self.hiddenMenuBtn addTarget: self action: @selector(showHiddenMenu) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: self.hiddenMenuBtn];
        
        self.lineView       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPAD ? 768 : 640, IPAD ? 2 : 1)];
        self.lineView.image = [UIImage imageNamed: @"separator"];
        [self addSubview: self.lineView];
        
        self.lbl               = [UILabel new];
        self.lbl.textAlignment = NSTextAlignmentCenter;
        self.lbl.textColor     = [UIColor whiteColor];
        self.lbl.font          = [UIFont dosisOfSize: 21];
        self.lbl.text = title;
        [self.lbl sizeToFit];
        [self addSubview: self.lbl];
        
        self.tableView                 = [[UITableView alloc] initWithFrame: CGRectMake(0, IPAD ? 65 : 30, self.frame.size.width, self.frame.size.height - 30) style: UITableViewStyleGrouped];
        self.tableView.rowHeight       = 75;
        self.tableView.delegate        = self;
        self.tableView.dataSource      = self;
        self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self addSubview: self.tableView];
        
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.hiddenMenuBtn.center = CGPointMake(self.frame.size.width - (IPAD ? 40 : 20), IPAD ? 30 : 15);
    self.lineView.center      = CGPointMake(self.frame.size.width/2, IPAD ? 65 : 30);
    self.lbl.center           = CGPointMake(self.frame.size.width/2, IPAD ? 30 : 15);
}

- (void) showHiddenMenu
{
    if([self.delegate respondsToSelector:@selector(showHiddenMenu)])
        [self.delegate showHiddenMenu];
    
    [self removeFromSuperview];
}

- (NSInteger)tableView: (UITableView*) tableView
 numberOfRowsInSection: (NSInteger)    section
{
    return [titleArr count];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    static NSString* cellIdentifier = @"cell";
    BaseTableViewCell* cell         = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    
    cell.backgroundColor = indexPath.row % 2 == 1 ? [UIColor colorWithRed: 132.0/255.0 green: 196.0/255.0 blue: 191.0/255.0 alpha: 0.015] : [UIColor clearColor];
    cell.lbl.text        = [NSString stringWithFormat: @"%@", titleArr[indexPath.row]];
    cell.delegate        = self;
    cell.arrowBtn.tag    = indexPath.row;
    cell.imgView.image   = [UIImage imageNamed:[NSString stringWithFormat: @"%@", imageArr[indexPath.row]]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (void) infoPressed: (UIButton*) sender
{
    currentItem = titleArr[sender.tag];
    if ([self.delegate respondsToSelector: @selector(infoPressed:)])
        [self.delegate infoPressed: sender];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IPAD ? 160 : 80;
}

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    UIButton* senderBtn = [UIButton new];
    senderBtn.tag = indexPath.row;
    [self infoPressed: senderBtn];
    senderBtn = nil;
}

@end
