//
//  define.h
//  EYoLo
//
//  Created by Jacky Nguyen on 3/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//
#import "Util.h"
#import "NetworkActivityIndicator.h"

#define kServer_Post_UserInfo @"http://server.teamios.info/apis/user_info"

#define kServer_Get_SpecialList @"http://server.teamios.info/apis/speciallist"
#define kServer_Get_DealList @"http://server.teamios.info/apis/deallist"
#define kServer_ImageURL @"http://server.teamios.info/img/"

#define mainAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define IMAGESPATH [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

#define HOMEDIRECTORY [[NSBundle mainBundle] resourcePath]

#define DOCUMENTDIRECTORY [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

#define LIBRARY_CATCHES_DIRECTORY [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/"]

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT  162
#else
#define IS_IPAD() (false)
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT  162
#endif
#define kUserInfo @"UserInfo"
#define kFirstLaunch @"FirstLaunch"
#define kDeviceId @"DeviceId"

#define kUser_Id @"id"
#define kUser_Name @"name"
#define kUser_Email @"email"
#define kUser_Age @"age"
#define kUser_Sex @"sex"
#define kUser_Postcode @"postcode"

