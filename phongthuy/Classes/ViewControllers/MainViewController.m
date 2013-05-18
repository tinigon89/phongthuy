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
#import "ServiceManager.h"
#import "DownloadManager.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "UIImageView+WebCache.h"
#import "define.h"

@interface MainViewController ()

@end

static NSString *cellIdentifier = @"CollectionViewCell";

@implementation MainViewController
@synthesize navBar,collectionViewFunction;

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
   [self.navBar setTitle:@"Phong thủy"];
    // Set color text navigation bar
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];

    [titleBarAttributes setValue:[UIColor blackColor] forKey:UITextAttributeTextColor];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    self.navigationItem.revealSidebarDelegate = self;
	
    NSString *deviceModel = [self getModel];
    dicListPhongThuy = [ServiceManager getListPhongThuyCategories:deviceModel];
    dicListFuntion = [ServiceManager getListPhongThuyFunctions];
    list_categories = [dicListPhongThuy objectForKey:@"list_categories"];
    listFunction = [dicListFuntion objectForKey:@"listFunction"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.view sendSubviewToBack:viewController.view];
    
    int pages = floor(self.collectionViewFunction.contentSize.height /
                      self.collectionViewFunction.frame.size.height) + 1;
    pageControl.numberOfPages = pages;
    pageControl.currentPage = 0;
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

- (IBAction)changePage:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.collectionViewFunction.frame.size.height ;
    frame.origin.y = self.collectionViewFunction.frame.size.height * pageControl.currentPage;
    frame.size = self.collectionViewFunction.frame.size;
    [self.collectionViewFunction scrollRectToVisible:frame animated:YES];
}
#pragma mark -
#pragma mark Rotation stuff

- (BOOL)shouldAutorotate {
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ((orientation == UIInterfaceOrientationLandscapeRight) || (orientation == UIInterfaceOrientationLandscapeLeft)) {
        return YES;
    }
    
    return NO;
}

#pragma mark JTRevealSidebarDelegate

- (UIView *)viewForLeftSidebar {

    CGRect viewFrame = self.navigationController.applicationViewFrame;

    viewController.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return viewController.view;
}

- (void)viewDidUnload {
    ScrollViewFunction = nil;
    [self setCollectionViewFunction:nil];
    pageControl = nil;
    [self setScrollViewFunction:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}


- (NSString *)getModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *sDeviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return  sDeviceModel;
}

#pragma mark -
#pragma mark PSUICollectionView stuff

- (NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [listFunction  count];
}


- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PSUICollectionViewCell *cell = (PSUICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dicItem = [listFunction objectAtIndex:indexPath.row];
    UILabel *label = (UILabel *)[cell viewWithTag:123];
    label.text  = [dicItem objectForKey:@"function_name"];
    
    UIImageView *imageiCon = (UIImageView *)[cell viewWithTag:321];
    
    NSString *urlIcon = nil;
    if (IS_IPAD()) {
        urlIcon = [dicItem objectForKey:@"function_icon_url_ipad"];
    }
    else
    {
        urlIcon = [dicItem objectForKey:@"function_icon_url"];
    }
    
    [imageiCon setImageWithURL:[NSURL URLWithString:urlIcon] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

#pragma mark Delegete crollview

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageHeight = self.collectionViewFunction.frame.size.height;
    self.pageControl.currentPage = (scrollView.contentOffset.y / pageHeight);
}

//- (PSUICollectionReusableView *)collectionView:(PSUICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//	NSString *identifier = nil;
//	
//	if ([kind isEqualToString:PSTCollectionElementKindSectionHeader]) {
//		identifier = headerViewIdentifier;
//	} else if ([kind isEqualToString:PSTCollectionElementKindSectionFooter]) {
//		identifier = footerViewIdentifier;
//	}
//    PSUICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
//    
//    // TODO Setup view
//    
//    return supplementaryView;
//}
@end
