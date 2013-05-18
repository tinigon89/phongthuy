//
//  DownloadManager.m
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/14/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import "DownloadManager.h"
#import "CGItem+Custom.h"
#import "ASIFormDataRequest.h"
#import "define.h"
#import "ServiceManager.h"
#import "DataParser.h"

static DownloadManager *sharedInstance;
@implementation DownloadManager

+ (DownloadManager*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[DownloadManager alloc] init];
    }
    return sharedInstance;
}

- (BOOL)downloadImageWithUrl:(NSString *)urlString path:(NSString *)path
{
    ASIFormDataRequest * request;
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200)
    {
        UIImage *image = [UIImage imageWithData:request.responseData];
        if (image) {
            NSError* error;
            if ([request.responseData writeToFile:path options:NSDataWritingAtomic error:&error]) {
                NSLog(@"Download sucessful");
                return YES;
            };
            NSLog(@"write error %@", error);
        }
    }
    NSLog(@"Download fail");
    return NO;
}

@end
