//
//  FacebookAPICall.h
//  FacebookFramework
//
//  Created by Gabriel Aliotta on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString* kAppId;
@class Facebook;

@interface FacebookAPICall : NSObject <UIApplicationDelegate>

@property (strong, nonatomic) Facebook * facebook;

+ (FacebookAPICall *)sharedFacebookAPICall;

- (void) login;
- (void)logout;
- (void)postMessageToWall;
- (void) postImageToWall:(UIImage *)image withMessage:(NSString *)message;
- (void)postLinkToWall:(NSString *)link 
             withTitle:(NSString *)title 
            andMessage:(NSString *)message 
        andDescription:(NSString *)description;

@end
