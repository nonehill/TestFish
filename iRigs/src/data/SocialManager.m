//
//  SocialManager.m
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import "SocialManager.h"
#import "AppDelegate.h"

@interface SocialManager ()

@property (nonatomic, strong) AppDelegate* appDelegate;

@end

@implementation SocialManager

+ (SocialManager*) shared
{
    static SocialManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype) init
{
    if (self = [super init])
        self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return self;
}

#pragma mark Facebook

- (void) sendFB
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: FACEBOOK_LINK]];
}

#pragma mark Mail

- (void) sendMail
{
    NSString* emailTitle =  @"Email title";
    NSString* messageBody = @"Message Body";
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
        if (mailClass != nil) {
            
            MFMailComposeViewController* mailSheet = [MFMailComposeViewController new];
            mailSheet.mailComposeDelegate          = self;
            [mailSheet setSubject: emailTitle];
            [mailSheet setMessageBody: messageBody isHTML: NO];
    
            if ([MFMailComposeViewController canSendMail]) {
                [self.appDelegate.navCon.visibleViewController presentViewController: mailSheet
                                                                            animated: YES
                                                                          completion: nil];
            }
        }
}

- (void)mailComposeController: (MFMailComposeViewController*) controller
          didFinishWithResult: (MFMailComposeResult) result
                        error: (NSError*) error
{
    switch (result) {
        case MFMailComposeResultSent:
            
            break;
            
        case MFMailComposeResultSaved:
            
            break;
            
        case MFMailComposeResultCancelled:
            
            break;
            
        case MFMailComposeResultFailed:
            
            break;
    }
    [self.appDelegate.navCon.visibleViewController dismissViewControllerAnimated: YES
                                                                      completion: nil];
}

#pragma mark Twitter

- (void) sendTweet
{
    if ([SLComposeViewController isAvailableForServiceType: SLServiceTypeTwitter]) {
    SLComposeViewController* twitterSheet = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
        [twitterSheet setInitialText: @"Hi twitter"];
        
    
        [twitterSheet setCompletionHandler: ^(SLComposeViewControllerResult result)
         {
             NSString* output = nil;
             switch (result) {
                 case SLComposeViewControllerResultDone:
                     output = @"Post Sucessfull";
                     break;
                     
                 case SLComposeViewControllerResultCancelled:
                     output = @"Post canceled";
                     
             }
             
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle: @"Twitter"
                                                             message: output
                                                            delegate: nil
                                                   cancelButtonTitle: @"ok"
                                                   otherButtonTitles: nil];
             [alert show];
         }];
    }
}

@end
