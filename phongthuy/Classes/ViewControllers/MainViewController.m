//
//  MainViewController.m
//  phongthuy
//
//  Created by Jacky Nguyen on 5/17/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "JTRevealSidebarV2Delegate.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    self.navigationItem.revealSidebarDelegate = self;
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.view sendSubviewToBack:viewController.view];
}

- (void)menuButtonPressed:(id)sender
{
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu_Click:(id)sender
{
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

#pragma mark JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar {

    CGRect viewFrame = self.navigationController.applicationViewFrame;

    viewController.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return viewController.view;
}

@end
