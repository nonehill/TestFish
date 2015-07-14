//
//  LeadSysVC.m
//  iRigs
//
//  Created by Serg T on 13.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "LeadSysVC.h"

@interface LeadSysVC () <BaseTableViewInfoDelegate, IntroItemViewDelegate, StepOneViewDelegate>

@property (nonatomic, strong) id            tag;
@property (nonatomic, assign) int           stepNumberRigs;
@property (nonatomic, strong) NSArray*      stepTextArray;
@property (nonatomic, strong) NSArray*      imgArray;
@property (nonatomic, strong) NSMutableArray* stepsArray;
@property (nonatomic, strong) StepOneView*  stepOne;
@property (nonatomic, strong) UIView*       currentStep;

@property (nonatomic, strong) BaseTableViewInfo* infoView;
@property (nonatomic, strong) UIView* firstView;

@end

@implementation LeadSysVC

- (void) loadView
{
    [super loadView];
    
    self.infoView = [[BaseTableViewInfo alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                  imageArray: LEAD_SYS_IMAGE_ARRAY
                                                  titleArray: LEAD_SYS_TITLE_ARRAY
                                                    andTitle: @"Lead Systems"];
    self.infoView.delegate = self;
    [self.view addSubview: self.infoView];
    
    self.stepTextArray = [NSArray new];
    self.imgArray      = [NSArray new];
    self.stepsArray    = [NSMutableArray new];
}

- (void) showHiddenMenu
{
    RigsMenuVC* rigsVC = [RigsMenuVC new];
    [self.navigationController pushViewController: rigsVC animated: NO];
}

- (void) infoPressed: (UIButton*) sender
{
    self.stepNumberRigs = 0;
    self.tag            = sender;
    
    NSString* infoText = [NSString new];
    
    switch (sender.tag) {
        case 0:
            self.stepTextArray = LEAD_SYSTEMS_CHOD_STEPS;
            infoText           = LEAD_SYSTEMS_CHOD_INFO;
            self.imgArray      = LEAD_SYSTEMS_CHOD_ICONS;
            break;
            
        case 1:
            self.stepTextArray = LEAD_SYSTEMS_DROP_OFF_STEPS;
            infoText           = LEAD_SYSTEMS_DROP_OFF_INFO;
            self.imgArray      = LEAD_SYSTEMS_DROP_OFF_ICONS ;
            break;
            
        case 2:
            self.stepTextArray = LEAD_SYSTEM_LEAD_CLIP_STEPS;
            infoText           = LEAD_SYSTEM_LEAD_CLIP_INFO;
            self.imgArray      = LEAD_SYSTEM_LEAD_CLIP_ICONS;
            break;
            
        case 3:
            self.stepTextArray = LEAD_SYS_LEADCORE_CHOD_STEPS;
            infoText           = LEAD_SYS_LEADCORE_CHOD_INFO;
            self.imgArray      = LEAD_SYS_LEADCORE_CHOD_ICONS;
            break;
            
        case 4:
            self.stepTextArray = LEAD_SYSTEMS_RUNNING_STEPS;
            infoText           = LEAD_SYSTEMS_RUNNING_INFO;
            self.imgArray      = LEAD_SYSTEMS_RUNNING_ICONS;
            break;
            
        case 5:
            self.stepTextArray = LEAD_SYSTEMS_SHOCKER_STEPS;
            infoText           = LEAD_SYSTEMS_SHOCKER_INFO;
            self.imgArray      = LEAD_SYSTEMS_SHOCKER_ICONS;
            break;
    }
    
    InfoItemView* intro = [[InfoItemView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                        title: @"Hi"
                                                      andInfo: infoText];
    intro.delegate = self;
    [self.view addSubview: intro];
    self.firstView = intro;
    self.stepOne = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                image: [UIImage imageNamed: [NSString stringWithFormat: @"%@",self.imgArray[self.stepNumberRigs]]]
                                                 step: 1
                                              andInfo: self.stepTextArray[self.stepNumberRigs]];
    
    self.stepOne.delegate = self;
}

#pragma mark IntroItemViewDelegate

- (void) introNextPressed
{
    [self.view addSubview: self.stepOne];
    [self.stepsArray addObject: self.stepOne];
    self.stepNumberRigs++;
}

#pragma mark StepOneViewDelegate

- (void) nextPressed: (UIButton*) sender
{
    self.stepNumberRigs++;
    StepOneView* nextStep = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                         image: [UIImage imageNamed: [NSString stringWithFormat: @"%@",self.imgArray[self.stepNumberRigs-1]]]
                                                          step: self.stepNumberRigs
                                                       andInfo: self.stepTextArray[self.stepNumberRigs-1]];
    
    if([self.stepTextArray count] == self.stepNumberRigs)
    {
        lastStep = YES;
        nextStep.nextBtn.hidden = YES;
    }else{
        nextStep.nextBtn.hidden = NO;
        
    }
    nextStep.delegate       = self;
    nextStep.prevBtn.hidden = NO;
    [self.stepOne addSubview: nextStep];
    [self.stepsArray addObject: nextStep];
    self.currentStep = nextStep;
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumberRigs, self.stepsArray);

}

- (void) previousPressed
{
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumberRigs, self.stepsArray);
    
    if([self.stepsArray count] > 1)
    {
        [self.currentStep removeFromSuperview];
        [self.stepsArray removeObjectAtIndex: self.stepNumberRigs-1];
        self.currentStep = (UIView*)self.stepsArray[self.stepNumberRigs-2];
    }else if ([self.stepsArray count] == 1){
        [(UIView*)self.stepsArray[0] removeFromSuperview];
        [self.stepsArray removeAllObjects];
    }
    self.stepNumberRigs--;
    [self checkSteps];
}

- (void) backStepPressed
{   
    lastStep = NO;
    self.stepNumberRigs--;
    [self checkSteps];
    [self.stepOne removeFromSuperview];
    [self.firstView removeFromSuperview];    
}

- (void) checkSteps
{
    if(self.stepNumberRigs < 0)
        self.stepNumberRigs = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
