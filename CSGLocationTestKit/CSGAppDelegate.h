//
//  CSGAppDelegate.h
//  CSGLocationTestKit
//
//  Created by rachel parsons on 2/12/13.
//  Copyright (c) 2013 Cardinal Solutions Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSGMainViewController;

@interface CSGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CSGMainViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
