//
//  define.h
//  EYoLo
//
//  Created by Jacky Nguyen on 3/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//
#import "Util.h"
#import "NetworkActivityIndicator.h"

#define kServerRoot                     @"http://sandbox.tuvi.me/"
#define kListPhongThuyCategories        @"/phongthuy.asmx/getListPhongThuyCategories"
#define kListPhongThuyFunctions         @"/phongthuy.asmx/getListPhongThuyFunctions"
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


