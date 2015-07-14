//
//  RigsVC.m
//  iRigs
//
//  Created by Serg T on 14.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "RigsVC.h"

@interface RigsVC () <BaseTableViewInfoDelegate, IntroItemViewDelegate, StepOneViewDelegate>

@property (nonatomic, strong) id            tag;
@property (nonatomic, assign) int           stepNumberRigs;
@property (nonatomic, strong) NSArray*      stepTextArray;
@property (nonatomic, strong) NSArray*      imgArray;
@property (nonatomic, strong) NSMutableArray* stepsArray;
@property (nonatomic, strong) UIView*       currentStep;
@property (nonatomic, strong) StepOneView*  stepOne;

@property (nonatomic, strong) BaseTableViewInfo* infoView;
@property (nonatomic, strong) UIView* firstView;

@end

@implementation RigsVC

- (void) loadView
{
    [super loadView];
    
    self.infoView = [[BaseTableViewInfo alloc] initWithFrame: CGRectMake(0, 0, 320, iPhone_4 ? 480 : 568)
                                                  imageArray: RIG_CONSTRUCTION_IMAGE_ARRAY
                                                  titleArray: RIG_CONSTRUCTION_TITLE_ARRAY
                                                    andTitle: @"Rigs"];
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
            self.stepTextArray = BLOW_BACK_RIG_STEPS;
            infoText           = BLOW_BACK_RIG_INFO;
            self.imgArray      = BLOW_BACK_RIG_ICONS;
            break;
            
        case 1:
            self.stepTextArray = BOTTOM_BAIT_RIG_STEPS;
            infoText           = BOTTOM_BAIT_RIG_INFO;
            self.imgArray      = BOTTOM_BAIT_RIG_ICONS ;
            break;
            
        case 2:
            self.stepTextArray = CHOD_RIG_STEPS;
            infoText           = CHOD_RIG_INFO;
            self.imgArray      = CHOD_RIG_ICONS;
            break;
            
        case 3:
            self.stepTextArray = COMBI_RIG_STEPS;
            infoText           = COMBI_RIG_INFO;
            self.imgArray      = COMBI_RIG_ICONS;
            break;
            
        case 4:
            self.stepTextArray = DF_RIG_STEPS ;
            infoText           = DF_RIG_INFO;
            self.imgArray      = DF_RIG_ICONS;
            break;
            
        case 5:
            self.stepTextArray = ELLIOT_GRAY_STEPS ;
            infoText           = ELLIOT_GRAY_INFO;
            self.imgArray      = ELLIOT_GRAY_ICONS;
            break;
            
        case 6:
            self.stepTextArray = HINGE_RIG_STEPS;
            infoText           = HINGE_RIG_INFO;
            self.imgArray      = HINGE_RIG_ICONS;
            break;
            
        case 7:
            self.stepTextArray = KD_RIG_STEPS;
            infoText           = KD_RIG_INFO;
            self.imgArray      = KD_RIG_ICONS;
            break;
            
        case 8:
            self.stepTextArray = MULTI_RIG_STEPS;
            infoText           = MULTI_RIG_INFO;
            self.imgArray      = MULTI_RIG_ICONS;
            break;
            
        case 9:
            self.stepTextArray = STIFF_FLOU_RIG_STEPS;
            infoText           = STIFF_FLOU_RIG_INFO;
            self.imgArray      = STIFF_FLOU_RIG_ICONS;
            break;
            
        case 10:
            self.stepTextArray = ZIG_STEPS;
            infoText           = ZIG_INFO;
            self.imgArray      = ZIG_ICONS;
            break;
            
    }
    
    InfoItemView* intro = [[InfoItemView alloc] initWithFrame: CGRectMake(0, 0, 320, iPhone_4 ? 480 : 568)
                                                        title: @"Hi"
                                                      andInfo: infoText];
    intro.delegate = self;
    [self.view addSubview: intro];
    self.firstView = intro;

    self.stepOne = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, iPhone_4 ? 480 : 568)
                                                image: [UIImage imageNamed: [NSString stringWithFormat: @"%@",self.imgArray[self.stepNumberRigs]]]
                                                 step: 1
                                              andInfo: self.stepTextArray[self.stepNumberRigs]];
    self.stepOne.stepLbl.text = @"Rig components needed";
    [self.stepOne.stepLbl sizeToFit];
    
    self.stepOne.delegate = self;
}

#pragma mark IntroItemViewDelegate

- (void) introNextPressed
{
    [self.view addSubview: self.stepOne];
    [self.stepsArray addObject: self.stepOne];
}

#pragma mark StepOneViewDelegate

- (void) nextPressed: (UIButton*) sender
{
    self.stepNumberRigs++;
    
    if([self.stepTextArray count] - 1 == self.stepNumberRigs){
        lastStep = YES;
    }
    
    StepOneView* nextStep = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, iPhone_4 ? 480 : 568)
                                                         image: [UIImage imageNamed: [NSString stringWithFormat: @"%@",self.imgArray[self.stepNumberRigs]]]
                                                          step: self.stepNumberRigs
                                                       andInfo: self.stepTextArray[self.stepNumberRigs]];
    
    if([self.stepTextArray count] - 1 == self.stepNumberRigs)
    {
        nextStep.nextBtn.hidden = YES;
    }else{
        nextStep.nextBtn.hidden = NO;
    }
    nextStep.delegate       = self;
    nextStep.prevBtn.hidden = NO;
    [self.stepOne addSubview: nextStep];
    self.currentStep = nextStep;
    [self.stepsArray addObject:nextStep];
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumberRigs, self.stepsArray);

}

- (void) previousPressed
{
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumberRigs, self.stepsArray);
    
    if([self.stepsArray count] > 1)
    {
        [self.currentStep removeFromSuperview];
        [self.stepsArray removeObjectAtIndex: self.stepNumberRigs];
        self.currentStep = (UIView*)self.stepsArray[self.stepNumberRigs-1];
    }else if ([self.stepsArray count] == 1){
        [(UIView*)self.stepsArray[0] removeFromSuperview];
        [self.stepsArray removeAllObjects];
    }
    self.stepNumberRigs--;
    [self checkSteps];
}

- (void) backStepPressed
{
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
@end
