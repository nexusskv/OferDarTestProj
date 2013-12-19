//
//  AppDelegate.h
//  OferDarTestProject
//
//  Created by Admin on 11/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadRingtonsController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, LoadRingtonsDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navContr;

@end
