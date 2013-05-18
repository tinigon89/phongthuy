//
//  MainViewController.h
//  phongthuy
//
//  Created by Jacky Nguyen on 5/17/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTRevealSidebarV2Delegate.h"
#import "PSTCollectionView.h"

@interface MainViewController : UIViewController<JTRevealSidebarV2Delegate,PSTCollectionViewDataSource,PSTCollectionViewDelegate>
{
    UIViewController *viewController;
    NSDictionary *dicListPhongThuy;
    NSDictionary *dicListFuntion;
    NSArray *listFunction;
    NSArray *list_categories;
    __weak IBOutlet UIScrollView *ScrollViewFunction;
    __weak IBOutlet UIPageControl *pageControl;
    BOOL pageControlUsed;
}

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollViewFunction;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFunction;
@property(weak, nonatomic) IBOutlet UINavigationItem *navBar;
- (IBAction)menu_Click:(id)sender;
- (IBAction)changePage:(id)sender;

@end
