//
//  AppDelegate.h
//  FacebookFramework
//
//  Created by Gabriel Aliotta on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBConnect.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) Facebook * facebook;
@property (strong, nonatomic) NSMutableDictionary * userPermissions;

@end
