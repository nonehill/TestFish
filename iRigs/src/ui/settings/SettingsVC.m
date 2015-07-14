//
//  SettingsVC.m
//  iRigs
//
//  Created by Serg T on 29.09.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingsView.h"
#import "RigsMenuVC.h"

@interface SettingsVC () <SettingsViewDelegate>

@property (nonatomic, strong) SettingsView* setView;
@property (nonatomic, strong) RigsMenuVC*   rigsMenu;

@end

@implementation SettingsVC

- (void)loadView
{
    [super loadView];
    self.view.frame       = CGRectMake(0, 0, IPAD ? 768 : 320, IPAD ? 1024 : 568);
    self.setView          = [SettingsView new];
    self.setView.delegate = self;
    [self.view addSubview: self.setView];
    
    self.rigsMenu    = [RigsMenuVC new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SettingsViewDelegate

- (void) hideMenu
{
        for (UIViewController* vc in [self.navigationController viewControllers]) {
            vc.view.center   = CGPointMake(self.navigationController.view.frame.size.width/2, self.navigationController.view.frame.size.height/2);
            self.view.center = CGPointMake(10, iPhone_4 ? self.view.frame.size.height/2 + 150 : self.view.frame.size.height/2);
        }
        self.view = nil;
}

- (void) settingsItemPressed: (UIButton*) sender
{
    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController: self.rigsMenu
                                                 animated: NO];
            break;
            
        case 1:
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://itunes.apple.com/us/app/biggest-carp-rigs/id890924732?l=ru&ls=1&mt=8"]];
            break;
            
        case 2:
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://biggestcarp.uk/"]];
            break;
            
        case 3:
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://skyellatech.com/"]];
            break;
            
    }
    [self hideMenu];
}


@end
