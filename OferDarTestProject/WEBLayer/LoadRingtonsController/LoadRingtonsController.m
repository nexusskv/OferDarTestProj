//
//  LoadRingtonsController.m
//  OferDarTestProject
//
//  Created by Admin on 12/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import "LoadRingtonsController.h"
#import "Reachability.h"

@implementation LoadRingtonsController


- (void)dealloc
{
    self.loadDelegate = nil;
    [super dealloc];
}

- (BOOL) isOnline
{
    BOOL resultFlag = FALSE;
    
    Reachability *internetReachability = [Reachability reachabilityForInternetConnection];
    if(([internetReachability currentReachabilityStatus] == ReachableViaWWAN) ||
	   ([internetReachability currentReachabilityStatus] == ReachableViaWiFi))
    {
        resultFlag = TRUE;
    }
    return resultFlag;
}

- (void) loadJSON
{
    NSURL *url = [NSURL URLWithString:@"http://onoapps.com/Dev/ringtones.txt"];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest requestWithURL:url] retain];
    request.timeOutSeconds = 300;
    [request setCompletionBlock:^{
        
        NSUInteger statusInt = [request responseStatusCode];
        NSString *responseString = [request responseString];
        
        if (statusInt != 200)
        {
            [self performSelector:@selector(loadResultSelector:) withObject:kEmptyMsg];
        }
        else
        {
            if ((responseString != nil) && (responseString.length > 0))
            {
                NSError *error;
                NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
                    
                if ((dataDic != nil) && ([dataDic allKeys] > 0))
                {
                    NSArray *ringsArr = [dataDic valueForKey:@"ringtones"];
                    if ([ringsArr count] > 0)
                    {
                        NSArray *emptyArr = nil;
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"rings.plist"];
                        [emptyArr writeToFile:filePath atomically:YES];
                        [ringsArr writeToFile:filePath atomically:YES];
                        [self performSelector:@selector(loadResultSelector:) withObject:kSuccessMsg];
                    }
                    else
                        {
                            [self performSelector:@selector(loadResultSelector:)
                                       withObject:kFileEmptyMsg];
                        }
                }
            }
            else
                {
                    [self performSelector:@selector(loadResultSelector:) withObject:kEmptyMsg];
                }
        }
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        
        [self loadResultSelector:error.description];
        
    }];
    [request setDelegate:self];
    [request startAsynchronous];
}


- (void) loadResultSelector:(NSString *)sender
{
    if ((self.loadDelegate) && ([self.loadDelegate respondsToSelector:@selector(loadResultWithReport:)]))
    {
        [self.loadDelegate loadResultWithReport:sender];
    }
}

@end
