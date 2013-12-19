//
//  AsyncImageDownloader.h
//  iGitLab
//
//  Created by Gress,Rostyslav on 10/2/12.
//  Copyright (c) 2012 Shere Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncImageDownloader : NSObject
+ (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage;
@end
