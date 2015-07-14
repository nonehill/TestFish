//
//  HookPatternsVC.m
//  iRigs
//
//  Created by Serg T on 14.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "HookPatternsVC.h"
#import "RigsMenuVC.h"

@interface HookPatternsVC () <StepOneViewDelegate>

@property (nonatomic, strong) StepOneView* firstHook;
@property (nonatomic, assign) int stepNumber;
@property (nonatomic, strong) NSArray* imgArray;
@property (nonatomic, strong) NSArray* infoArray;
@property (nonatomic, strong) NSArray* titleArray;
//@property (nonatomic, strong) StepOneView* nextHook;
@property (nonatomic, strong) NSMutableArray* stepsArray;
@property (nonatomic, strong) UIView* currentStep;

@end

@implementation HookPatternsVC

- (void) loadView
{
    [super loadView];
    self.stepNumber = 0;
    self.imgArray   = HOOK_PATTERNS_IMAGE_ARRAY;
    self.infoArray  = HOOK_PATTERNS_INFO_ARRAY;
    self.titleArray = HOOK_PATTERNS_TITLE_ARRAY;
    
    self.firstHook  = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                   image: [UIImage imageNamed: [NSString stringWithFormat: @"%@", self.imgArray[self.stepNumber]]]
                                                    step: 0
                                                 andInfo: self.infoArray[self.stepNumber]];
    
    self.firstHook.stepLbl.text   = self.titleArray[self.stepNumber];
    self.firstHook.delegate       = self;
    self.firstHook.prevBtn.hidden = YES;
    self.firstHook.lbl.text       = @"Hook Patterns";
    [self.firstHook.lbl sizeToFit];
    [self.firstHook.stepLbl sizeToFit];
    [self.view addSubview: self.firstHook];
    self.stepsArray = [NSMutableArray new];
}

#pragma mark StepOneViewDelegate

- (void) nextPressed: (UIButton*) sender
{
    self.stepNumber++;

    if (self.stepNumber == 6){
        lastStep = YES;
    }
    
    StepOneView* nextHook = [[StepOneView alloc] initWithFrame: CGRectMake(0, 0, 320, 568)
                                                         image: [UIImage imageNamed: [NSString stringWithFormat: @"%@", self.imgArray[self.stepNumber]]]
                                                          step: 0
                                                       andInfo: self.infoArray[self.stepNumber]];
    nextHook.lbl.text     = @"Hook Patterns";
    nextHook.stepLbl.text = self.titleArray[self.stepNumber];
    nextHook.delegate     = self;
    [nextHook.stepLbl sizeToFit];
    [nextHook.lbl sizeToFit];
    
    if (self.stepNumber == 6){
        nextHook.nextBtn.hidden = YES;
    }
    
    [self.firstHook addSubview: nextHook];
    [self.stepsArray addObject: nextHook];
    self.currentStep = nextHook;
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumber, self.stepsArray);

}

- (void) previousPressed
{
    NSLog(@"previousPressed step number = %d arryViews %@", self.stepNumber, self.stepsArray);

    if (self.stepNumber == 0) {
        [self.navigationController pushViewController: [RigsMenuVC new]
                                             animated: NO];
    }
    else if([self.stepsArray count] > 1)
    {
    [self.currentStep removeFromSuperview];
    [self.stepsArray removeObjectAtIndex: self.stepNumber-1];
    self.currentStep = (UIView*)self.stepsArray[self.stepNumber-2];
    }else if ([self.stepsArray count] == 1){
        [(UIView*)self.stepsArray[0] removeFromSuperview];
        [self.stepsArray removeAllObjects];
    }
    
    lastStep = NO;
    
    self.stepNumber--;
}

- (void) backStepPressed
{
    lastStep = NO;
    RigsMenuVC* rigsMenuVC = [RigsMenuVC new];
    [self.navigationController pushViewController: rigsMenuVC
                                         animated: NO];
}



@end
