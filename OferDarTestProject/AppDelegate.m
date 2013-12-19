//
//  AppDelegate.m
//  OferDarTestProject
//
//  Created by Admin on 11/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"


@implementation AppDelegate

@synthesize navContr;

- (void)dealloc
{
    SAFE_RELEASE(_window);
    SAFE_RELEASE(navContr);
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self loadRings];
    
    MainViewController *mainViewContr = [[MainViewController alloc] init];
    
    self.navContr = [[[UINavigationController alloc] initWithRootViewController:mainViewContr] autorelease];    
    self.window.rootViewController = self.navContr;
    SAFE_RELEASE(mainViewContr);
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadRings
{
    LoadRingtonsController *loadRinsContr = [[LoadRingtonsController alloc] init];
    loadRinsContr.loadDelegate = self;
    if ([loadRinsContr isOnline])
    {
        [loadRinsContr loadJSON];
    }
    SAFE_RELEASE(loadRinsContr);
}

- (void)loadResultWithReport:(NSString *)resStr
{
    if (![resStr isEqualToString:kSuccessMsg])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                        message:resStr
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert  show];
        SAFE_RELEASE(alert);
    }
}

@end
