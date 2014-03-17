//
//  ASAppDelegate.h
//  UIDocument-xcode4
//
//  Created by Brovko Roman on 17.03.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASViewController;

@interface ASAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ASViewController *viewController;

@end
