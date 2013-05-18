//
//  DataParser.m
//  phongthuy
//
//  Created by TonyNguyen on 5/18/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import "DataParser.h"
#import "NSString+SBJSON.h"

@implementation DataParser

+ (NSDictionary *)parserListCategoryPhongthuy:(NSData *)data
{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return [jsonString JSONValue];
}

@end
