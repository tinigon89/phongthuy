//
//  ServiceManager.m
//  CountryGrocer
//
//  Created by Tony Nguyen on 5/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//
//
#import "ServiceManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "define.h"
#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import <AdSupport/AdSupport.h>
#import "CGItem+Custom.h"
@implementation ServiceManager 

+ (NSDictionary *)getListPhongThuyCategories:(NSString *)deviceType
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerRoot,kListPhongThuyCategories]];
    NSError *error;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:deviceType forKey:@"device_type"];
    [request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        return [response JSONValue];
    }
    return nil;
}

+ (NSDictionary *)getListPhongThuyFunctions
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kServerRoot,kListPhongThuyFunctions]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        return [response JSONValue];
    }
    return nil;
}
@end
