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

@property (retain, nonatomic) Facebook * facebook;

+ (FacebookAPICall *)sharedFacebookAPICall;

- (void)login;
- (void)logout;
- (void)postMessageToWall;
- (void)postMessageToWall:(NSString *)message withImage:(UIImage *)image;
- (void)postLinkToWall:(NSString *)link 
                withTitle:(NSString *)title 
           andDescription:(NSString *)description;


@end
