//
//  ViewController.m
//  FacebookFramework
//
//  Created by Gabriel Aliotta on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FacebookAPICall.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *profilePhotoImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *postWall;

@end

@implementation ViewController

@synthesize nameLabel;
@synthesize profilePhotoImageView;
@synthesize loginButton;
@synthesize postWall;

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    [view release];
    
    // Login Button
    self.loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    CGFloat xLoginButtonOffset = self.view.center.x - (318/2);
    CGFloat yLoginButtonOffset = self.view.bounds.size.height - (400);
    loginButton.frame = CGRectMake(xLoginButtonOffset,yLoginButtonOffset,318,58);
    [loginButton addTarget:self
                    action:@selector(login)
          forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage:
     [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookNormal@2x.png"]
                 forState:UIControlStateNormal];
    [loginButton setImage: [UIImage imageNamed:@"FBConnect.bundle/images/LoginWithFacebookPressed@2x.png"] forState:UIControlStateHighlighted];
    [loginButton sizeToFit];
    [self.view addSubview:loginButton];
    
    // Post Button
    self.postWall = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    postWall.frame = CGRectMake(1 , 200, 318, 38);
    [postWall addTarget:self action:@selector(postWallClick) forControlEvents:UIControlEventTouchUpInside];
    [postWall setTitle:@"Post in your wall" forState:UIControlStateNormal];    
    [self.view addSubview:postWall];
    
    // Post photo Button
    UIButton * postPhotoBnt = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    postPhotoBnt.frame = CGRectMake(1 , 250, 318, 38);
    [postPhotoBnt addTarget:self action:@selector(postWallPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [postPhotoBnt setTitle:@"Post a photo in your wall" forState:UIControlStateNormal];    
    [self.view addSubview:postPhotoBnt];
    
    // Post Link Button
    UIButton * postLinkBnt = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    postLinkBnt.frame = CGRectMake(1 , 300, 318, 38);
    [postLinkBnt addTarget:self action:@selector(postWallLinkClick) forControlEvents:UIControlEventTouchUpInside];
    [postLinkBnt setTitle:@"Post a Link in your wall" forState:UIControlStateNormal];    
    [self.view addSubview:postLinkBnt];
    
    // Logout Button
    UIButton * logoutBnt = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    logoutBnt.frame = CGRectMake(1 , 370, 318, 58);
    [logoutBnt addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutBnt setTitle:@"Logout" forState:UIControlStateNormal];    
    [self.view addSubview:logoutBnt];    
}


#pragma CALLS TO TPG FACEBOOK LIBRARY METHODS

- (void)login {
    [[FacebookAPICall sharedFacebookAPICall] login];
    [loginButton setHidden:YES];  
    [postWall setHidden:NO];

}


- (void)logout {
    [[FacebookAPICall sharedFacebookAPICall] logout];
    [loginButton setHidden:NO];
}

- (void)postWallClick {
    [[FacebookAPICall sharedFacebookAPICall] postMessageToWall];
}

- (void) postWallPhotoClick {
    
    // IMAGE params
    NSURL *url = [NSURL URLWithString: 
                  @"http://mobiledevelopertips.com/images/logo-iphone-dev-tips.png"];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];    
    NSString * message = @"My Testing message";
    
    [[FacebookAPICall sharedFacebookAPICall] postImageToWall:image withMessage:message];

}

- (void)postWallLinkClick {    

    //LINK params
    NSString * link = @"https://www.google.com";
    NSString * title = @"My Testing Link";
    NSString * message = @"My Testing Message";
    NSString * description = @"My Testing description";    
    
    [[FacebookAPICall sharedFacebookAPICall] postLinkToWall:link withTitle:title andMessage:message andDescription:description];    
}


@end
