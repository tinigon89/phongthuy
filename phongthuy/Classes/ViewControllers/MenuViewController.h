//
//  MenuViewController.h
//  phongthuy
//
//  Created by TonyNguyen on 5/17/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIImageView *imageAvatar;
    __weak IBOutlet UILabel *lblName;    
}
@property (weak, nonatomic) IBOutlet UITableView *tableMenu;
@end
