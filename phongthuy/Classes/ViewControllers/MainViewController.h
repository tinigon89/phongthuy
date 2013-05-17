//
//  MainViewController.h
//  phongthuy
//
//  Created by Jacky Nguyen on 5/17/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTRevealSidebarV2Delegate.h"
@interface MainViewController : UIViewController<JTRevealSidebarV2Delegate>
{
    UIViewController *viewController;
}
- (IBAction)menu_Click:(id)sender;

@end
