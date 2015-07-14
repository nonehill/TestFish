//
//  KnotsVC.m
//  iRigs
//
//  Created by Serg T on 15.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "KnotsVC.h"

@interface KnotsVC () <BaseTableViewInfoDelegate, IntroItemViewDelegate, StepOneViewDelegate>

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

@implementation KnotsVC

- (void) loadView
{
    [super loadView];
    
    self.infoView = [[BaseTableViewInfo alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                  imageArray: KNOTS_IMAGE_ARRAY
                                                  titleArray: KNOTS_TITLE_ARRAY
                                                    andTitle: @"Knots"];
    self.infoView.delegate = self;
    [self.view addSubview: self.infoView];
    
    self.stepTextArray = [NSArray new];
    self.imgArray      = [NSArray new];
    self.stepsArray     = [NSMutableArray new];
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
    NSArray* knotsInfo = KNOTS_INFO_ARRAY;
    infoText = [NSString stringWithFormat: @"%@", knotsInfo[sender.tag]];
    
    switch (sender.tag) {
        case 0:
            self.stepTextArray = ALBRIGHT_KNOT_STEPS;
            self.imgArray      = ALBRIGHT_KNOT_ICONS;
            break;
            
        case 1:
            self.stepTextArray = FIGURE_KNOT_STEPS;
            self.imgArray      = FIGURE_KNOT_ICONS ;
            break;
            
        case 2:
            self.stepTextArray = GRANNY_KNOT_STEPS;
            self.imgArray      = GRANNY_KNOT_ICONS;
            break;
            
        case 3:
            self.stepTextArray = GRINNER_KNOT_STEPS;
            self.imgArray      = GRINNER_KNOT_ICONS;
            break;
            
        case 4:
            self.stepTextArray = HALF_BLOOD_KNOT_STEPS;
            self.imgArray      = HALF_BLOOD_KNOT_ICONS;
            break;
            
        case 5:
            self.stepTextArray = KNOTLESS_KNOT_STEPS;
            self.imgArray      = KNOTLESS_KNOT_ICONS;
            break;
            
        case 6:
            self.stepTextArray = MARKER_KNOT_STEPS;
            self.imgArray      = MARKER_KNOT_ICONS;
            break;
            
        case 7:
            self.stepTextArray = PALOMAR_KNOT_STEPS;
            self.imgArray      = PALOMAR_KNOT_ICONS;
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
    DLog(@"step number %d", self.stepNumberRigs);
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
        nextStep.nextBtn.hidden = YES;
    else
        nextStep.nextBtn.hidden = NO;
        
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
    DLog(@"step number %d", self.stepNumberRigs);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
