//
//  LoadRingtonsController.h
//  OferDarTestProject
//
//  Created by Admin on 12/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoadRingtonsDelegate;

@interface LoadRingtonsController : NSObject
@property (nonatomic, assign) id <LoadRingtonsDelegate> loadDelegate;

- (BOOL)isOnline;
- (void)loadJSON;
@end


@protocol LoadRingtonsDelegate <NSObject>

- (void)loadResultWithReport:(NSString *)resStr;

@end
