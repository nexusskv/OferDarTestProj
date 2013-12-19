//
//  AsyncImageDownloader.m
//  iGitLab
//
//  Created by Gress,Rostyslav on 10/2/12.
//  Copyright (c) 2012 Shere Consulting. All rights reserved.
//

#import "AsyncImageDownloader.h"

@implementation AsyncImageDownloader

+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    //dispatch_queue_t callerQueue = dispatch_get_current_queue();

    dispatch_queue_t downloadQueue = dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    //dispatch_queue_create("loadQueue", NULL);
    
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            processImage(imageData);
        });
    });
    dispatch_release(downloadQueue);    
}

@end
