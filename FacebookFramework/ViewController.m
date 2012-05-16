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

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIImageView *profilePhotoImageView;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIButton *postWall;
@property (nonatomic, retain) UIView * infoView;

@end

@implementation ViewController

@synthesize nameLabel;
@synthesize profilePhotoImageView;
@synthesize loginButton;
@synthesize postWall;
@synthesize infoView;

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    [view release];
    
    // Info Button
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(200 , 0, 150, 150);
    [infoButton addTarget:self action:@selector(infoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    // Login Button
    self.loginButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    CGFloat xLoginButtonOffset = self.view.center.x - (318/2);
    CGFloat yLoginButtonOffset = self.view.bounds.size.height - (370);
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
}


#pragma CALLS TO TPG FACEBOOK LIBRARY METHODS

- (void)login {
    [[FacebookAPICall sharedFacebookAPICall] login];
    [loginButton setHidden:YES];
    [postWall setHidden:NO];
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
    
    [[FacebookAPICall sharedFacebookAPICall] postMessageToWall:message withImage:image];

}

- (void)postWallLinkClick {    

    //LINK params
    NSString * link = @"https://www.google.com";
    NSString * title = @"My Testing Link";
    NSString * description = @"My Testing description";    
    
    [[FacebookAPICall sharedFacebookAPICall] postLinkToWall:link withTitle:title andDescription:description];    
}

- (void) infoButtonClick 
{
    infoView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [infoView setBackgroundColor:[UIColor whiteColor]]; 
    
    // Go Back Button
    UIButton * goBack= [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    goBack.frame = CGRectMake(1 , 5, 318, 38);
    [goBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [goBack setTitle:@"Go Back" forState:UIControlStateNormal];    
    [infoView addSubview:goBack];
    
    UITextView * textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(1 , 58, 320, 400);
    [textView setText:@"Post in your wall button shows a dialog to post a message on your wall \n\n Post a photo in your wall button gets an image from URL http://mobiledevelopertips.com/images/logo-iphone-dev-tips.png and use the text 'My Testing Link' as a message to test the photo post \n\n Post link in your wall shows a dialog and use the web page of google 'www.google.com' and with title 'My testing Link' and description 'My testing description' to test the post of links in your wall"];
    
    [infoView addSubview:textView];         
    [textView release];
                                 
    [self.view addSubview:infoView];
    [infoView release];
}

-(void) goBack
{
    [infoView removeFromSuperview];
}

@end
