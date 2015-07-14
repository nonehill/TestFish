//
//  LeadsVC.m
//  iRigs
//
//  Created by Serg T on 15.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "LeadsVC.h"

@interface LeadsVC () <BaseTableViewInfoDelegate, StepOneViewDelegate>

@property (nonatomic, strong) id            tag;
@property (nonatomic, assign) int           stepNumberRigs;
@property (nonatomic, strong) NSArray*      stepTextArray;
@property (nonatomic, strong) NSArray*      imgArray;
@property (nonatomic, strong) StepOneView*  stepOne;

@property (nonatomic, strong) BaseTableViewInfo* infoView;
@property (nonatomic, strong) UIView* firstView;

@end

@implementation LeadsVC

- (void) loadView
{
    [super loadView];
    
    self.infoView = [[BaseTableViewInfo alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                  imageArray: LEADS_IMAGE_ARRAY
                                                  titleArray: LEADS_TITLE_ARRAY
                                                    andTitle: @"Leads"];
    self.infoView.delegate = self;
    [self.view addSubview: self.infoView];
    
    self.stepTextArray = LEADS_INFO_ARRAY;
    self.imgArray      = LEADS_IMAGE_ARRAY;
}

- (void) showHiddenMenu
{
    RigsMenuVC* rigsVC = [RigsMenuVC new];
    [self.navigationController pushViewController: rigsVC animated: NO];
}

- (void) infoPressed: (UIButton*) sender
{
    self.stepNumberRigs = 1;
    self.tag            = sender;
    
    self.stepOne = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                image: [UIImage imageNamed: [NSString stringWithFormat: @"%@", self.imgArray[sender.tag]]]
                                                 step: 0
                                              andInfo: self.stepTextArray[sender.tag]];
    self.stepOne.stepLbl.text   = @"Info";
    self.stepOne.delegate       = self;
    self.stepOne.nextBtn.hidden = YES;
    self.stepOne.prevBtn.hidden = YES;
    self.stepOne.textView.frame =  CGRectMake(0, 0, self.stepOne.frame.size.width - 15, IPAD ? 320 : iPhone_4 ? 127 : 190);
    [self.view addSubview: self.stepOne];
}

- (void) backStepPressed
{
    [self.stepOne removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
