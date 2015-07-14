//
//  RigsMenuVC.m
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "RigsMenuVC.h"
#import "SettingsVC.h"
#import "RigsMenuView.h"
#import "LeadSysVC.h"
#import "RigsVC.h"
#import "HookPatternsVC.h"
#import "KnotsVC.h"
#import "LeadsVC.h"

@interface RigsMenuVC () <RigsMenuViewDelegate, BaseViewDelegate>

@property (nonatomic, strong) SettingsVC*  settingsVC;

@end

@implementation RigsMenuVC

- (void) loadView
{
    [super loadView];
    lastStep = NO;

    RigsMenuView* rigsView = [[RigsMenuView alloc] initWithFrame: CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : iPhone_4 ? 480 : 568)];
    rigsView.delegate = self;
    [self.view addSubview: rigsView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BaseViewDelegate

- (void) showHiddenMenu
{
    self.settingsVC = [SettingsVC new];
    self.settingsVC.view.center = CGPointMake(20, self.view.frame.size.height / 2);
    
    [self.navigationController addChildViewController: self.settingsVC];
    [self.navigationController.view addSubview: self.settingsVC.view];
    
    [UIView animateWithDuration: 0.03 animations:^{
        self.settingsVC.view.center = CGPointMake(IPAD ? self.navigationController.view.frame.size.width/2 : 150, iPhone_4 ? self.navigationController.view.frame.size.height/2 + 44 : self.navigationController.view.frame.size.height/2);
        self.view.center = CGPointMake(IPAD ? 550 : 300, self.view.frame.size.height/2);
    }];

}

#pragma mark RigsMenuViewDelegate

- (void) menuItemPressed: (UIButton*) sender
{
    NSLog(@"tapped");
    switch (sender.tag) {
        case 0:
        {
            RigsVC* rigsVC = [RigsVC new];
            [self.navigationController pushViewController: rigsVC
                                                 animated: NO];
            break;
        }
            
        case 1:
        {
            LeadSysVC* leadSysVC = [LeadSysVC new];
            [self.navigationController pushViewController: leadSysVC
                                                 animated: NO];
            break;
        }
            
        case 2:
        {
            KnotsVC* knotsVC = [KnotsVC new];
            [self.navigationController pushViewController: knotsVC
                                                 animated: NO];
            break;
        }
            
        case 3:
        {
            HookPatternsVC* hookPatternVC = [HookPatternsVC new];
            [self.navigationController pushViewController: hookPatternVC
                                                 animated: NO];
            break;
        }
            
        case 4:
        {
            LeadsVC* leadsVC = [LeadsVC new];
            [self.navigationController pushViewController: leadsVC
                                                 animated: NO];
            break;
        }
        case 5:
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://itunes.apple.com/us/app/biggest-carp/id849665740?l=ru&ls=1&mt=8"]];
            break;
    }
}

@end
