////
////  ServiceManager.m
////  CountryGrocer
////
////  Created by Jacky Nguyen on 5/13/13.
////  Copyright (c) 2013 teamios. All rights reserved.
////
//
//#import "ServiceManager.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
//#import "define.h"
//#import "NSObject+SBJSON.h"
//#import "NSString+SBJSON.h"
//#import <AdSupport/AdSupport.h>
//#import "CGItem+Custom.h"
//@implementation ServiceManager
//+ (void)postUserInfo
//{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dict = [userDefault objectForKey:kUserInfo];
//    NSString *post = [dict JSONRepresentation];
//    NSString *postString = [NSString stringWithFormat:@"content=%@",post];
//    NSData *postData = [postString  dataUsingEncoding:NSUTF8StringEncoding];
//    ASIFormDataRequest * request;
//    NSURL *url = [NSURL URLWithString:kServer_Post_UserInfo];
//    request = [ASIHTTPRequest requestWithURL:url];
//    [request addRequestHeader:@"Accept" value:@"application/json"];
//    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [postData length]]];
//    [request setPostBody:[NSMutableData dataWithData:postData]];
//    [request startSynchronous];
//    
//    if ([request responseStatusCode] == 200) {
//        if ([request.responseString isEqualToString:@"true"])
//        {
//            NSLog(@"success");
//        }
//    }
//}
//
//+ (BOOL)getSpecialList
//{
//    ASIFormDataRequest * request;
//    NSURL *url = [NSURL URLWithString:kServer_Get_SpecialList];
//    request = [ASIHTTPRequest requestWithURL:url];
//    [request setRequestMethod:@"GET"];
//    [request startSynchronous];
//    
//    if ([request responseStatusCode] == 200) {
//        NSDictionary *dict = [request.responseString JSONValue];
//        if (dict)
//        {
//            NSMutableArray *oldArrayList = [[CGItem getCGItems:1] mutableCopy];
//            NSArray *itemList = [dict objectForKey:@"ras"];
//            for (NSDictionary *itemDict in itemList) {
//                NSString *itemId = [itemDict objectForKey:@"id"];
//                for (CGItem *oldItem in oldArrayList) {
//                    if ([oldItem.uid isEqual:itemId]) {
//                        [oldArrayList removeObject:oldItem];
//                        break;
//                    }
//                }
//                CGItem *item = [CGItem getCGItemByUID:itemId];
//                if(!item)
//                {
//                    if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
//                    {
//                        continue;
//                    }
//                    item = [CGItem newCGItem];
//                }
//                else if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
//                {
//                    [CGItem deleteCGItem:item];
//                    continue;
//                }
//                
//                
//                item.uid = [itemDict objectForKey:@"id"];
//                item.name = [itemDict objectForKey:@"name"];
//                item.imageUrl = [itemDict objectForKey:@"pic"];
//                item.itemDescription = [itemDict objectForKey:@"description"];
//                item.price = [itemDict objectForKey:@"price"];
//                item.specials = [NSNumber numberWithBool:YES];
//                if (item.editDate && ![item.editDate isEqualToString:[itemDict objectForKey:@"edit_date"]]) {
//                    item.imageStorePath = nil;
//                }
//                
//                item.editDate = [itemDict objectForKey:@"edit_date"];
//                [CGItem updateCGItem:item];
//            }
//            for (CGItem *oldItem in oldArrayList) {
//                [CGItem deleteCGItem:oldItem];
//            }
//        }
//        return YES;
//    }
//    return NO;
//}
//
//+ (BOOL)getDealList
//{
//    ASIFormDataRequest * request;
//    NSURL *url = [NSURL URLWithString:kServer_Get_DealList];
//    request = [ASIHTTPRequest requestWithURL:url];
//    [request setRequestMethod:@"GET"];
//    [request startSynchronous];
//    
//    if ([request responseStatusCode] == 200) {
//        NSDictionary *dict = [request.responseString JSONValue];
//        if (dict)
//        {
//            NSMutableArray *oldArrayList = [[CGItem getCGItems:0] mutableCopy];
//            NSArray *itemList = [dict objectForKey:@"ras"];
//            for (NSDictionary *itemDict in itemList) {
//                NSString *itemId = [itemDict objectForKey:@"id"];
//                for (CGItem *oldItem in oldArrayList) {
//                    if ([oldItem.uid isEqual:itemId]) {
//                        [oldArrayList removeObject:oldItem];
//                        break;
//                    }
//                }
//                CGItem *item = [CGItem getCGItemByUID:itemId];
//                if(!item)
//                {
//                    if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
//                    {
//                        continue;
//                    }
//                    item = [CGItem newCGItem];
//                }
//                else if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
//                {
//                    [CGItem deleteCGItem:item];
//                    continue;
//                }
//                
//                
//                item.uid = [itemDict objectForKey:@"id"];
//                item.name = [itemDict objectForKey:@"name"];
//                item.imageUrl = [itemDict objectForKey:@"pic"];
//                item.itemDescription = [itemDict objectForKey:@"description"];
//                item.price = [itemDict objectForKey:@"price"];
//                item.specials = [NSNumber numberWithBool:NO];
//                if (item.editDate && ![item.editDate isEqualToString:[itemDict objectForKey:@"edit_date"]]) {
//                    item.imageStorePath = nil;
//                }
//                
//                item.editDate = [itemDict objectForKey:@"edit_date"];
//                [CGItem updateCGItem:item];
//            }
//            for (CGItem *oldItem in oldArrayList) {
//                [CGItem deleteCGItem:oldItem];
//            }
//        }
//        return YES;
//    }
//    return NO;
//}
//
//@end
