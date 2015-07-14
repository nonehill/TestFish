//
//  SocialManager.h
//  iRigs
//
//  Created by Serg on 01.10.14.
//  Copyright (c) 2014 fgf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface SocialManager : NSObject <MFMailComposeViewControllerDelegate, UIApplicationDelegate>

+ (SocialManager*) shared;

- (void) sendMail;
- (void) sendTweet;
- (void) sendFB;

@end
