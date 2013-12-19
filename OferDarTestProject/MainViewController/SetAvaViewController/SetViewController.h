//
//  SetViewController.h
//  OferDarTestProject
//
//  Created by Admin on 11/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetAvaDelegate;

@interface SetViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) BOOL setAvaFlag;
@property (nonatomic, assign) id <SetAvaDelegate> setAvaDelegate;
@end


@protocol SetAvaDelegate <NSObject>
- (void) setData:(id)objValue;
@end