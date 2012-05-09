//
//  ViewController.h
//  FacebookFramework
//
//  Created by Gabriel Aliotta on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBConnect.h"

@interface ViewController : UIViewController <FBRequestDelegate,FBDialogDelegate, FBSessionDelegate>


@property (nonatomic, strong) NSArray *permissions;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *profilePhotoImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *postWall;

- (void)showLoggedIn;
- (void)showLoggedOut;
- (void)apiFQLIMe;
- (void)postWallClick;

@end
