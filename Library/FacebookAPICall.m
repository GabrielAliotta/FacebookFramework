//
//  FacebookAPICall.m
//  FacebookFramework
//
//  Created by Gabriel Aliotta on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookAPICall.h"
#import "AppDelegate.h"
#import "FBConnect.h"
#import "SynthesizeSingleton.h"

@interface FacebookAPICall () <FBRequestDelegate,FBDialogDelegate, FBSessionDelegate>

@property (strong, nonatomic) NSMutableDictionary * userPermissions;

@end

@implementation FacebookAPICall
@synthesize facebook = _facebook;
@synthesize userPermissions = _userPermissions;
SYNTHESIZE_SINGLETON_FOR_CLASS(FacebookAPICall)


- (id)init
{
    self = [super init];
    if (self) {
        _facebook = [[Facebook alloc] initWithAppId:[kAppId copy] andDelegate:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] &&
            [defaults objectForKey:@"FBExpirationDateKey"]) {
            _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        // Initialize user permissions
        self.userPermissions = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}


#pragma mark UIApplicationDelegate
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Although the SDK attempts to refresh its access tokens when it makes API calls,
    // it's a good practice to refresh the access token also when the app becomes active.
    // This gives apps that seldom make api calls a higher chance of having a non expired
    // access token.
    [_facebook extendAccessTokenIfNeeded];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [_facebook handleOpenURL:url];
}


#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {    
    
    [self storeAuthData:[_facebook accessToken] expiresAt:[_facebook expirationDate]];      
}

-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];

}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}

#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}

#pragma TPG CALLS TO FACEBOOK API

-(void) login {
    // Initialize permissions
    NSArray * permissions = [[[NSArray alloc] initWithObjects:@"read_stream", @"publish_stream",@"offline_access", nil] autorelease];    
    
    if (![_facebook isSessionValid]) {
        [_facebook authorize:permissions];        
    }
    [permissions release];
}

- (void)logout {
    [_facebook logout];      
}

- (void)postMessageToWall {
    [_facebook dialog:@"feed" andDelegate:self];
}

- (void) postImageToWall:(UIImage *)image withMessage:(NSString *)message{
    
    NSMutableDictionary* imageParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         image,@"source",
                                         message,@"message",
                                         nil];
    
    [_facebook requestWithGraphPath:@"me/photos"
                                    andParams:imageParams
                                andHttpMethod:@"POST"
                                  andDelegate:self];   
}

- (void)postLinkToWall:(NSString *)link withTitle:(NSString *)title andMessage:(NSString *)message andDescription:(NSString *)description{

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   link, @"link",
                                   title, @"name",
                                   message,  @"message",
                                   description, @"description",
                                   nil];
    
    [_facebook dialog:@"feed" andParams:params andDelegate:self];    
}

-(void)dealloc
{
    [_userPermissions release];
}

@end
