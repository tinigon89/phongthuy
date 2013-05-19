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

@implementation MainViewController
@synthesize navBar,collectionViewFunction,pageControl,ScrollViewFunction,collectionViewCategory;

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
    
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp;
    [swipeGesture addTarget:self action:@selector(handleSwipeGesture:)];
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.view sendSubviewToBack:viewController.view];    
    int pages = floor(self.collectionViewFunction.contentSize.height /
                      self.collectionViewFunction.frame.size.height);
    pageControl.numberOfPages = pages;
    pageControl.currentPage = 0;

    [self.collectionViewFunction setContentSize:CGSizeMake(self.view.frame.size.width*pages, self.view.frame.size.height)];
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
    return NO;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ((orientation == UIInterfaceOrientationPortrait) || (orientation == UIInterfaceOrientationPortrait)) {
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
    [self setCollectionViewCategory:nil];
    swipeGesture = nil;
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

- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    int numberOfItems = 0;
    if (collectionView == (PSUICollectionView*)self.collectionViewCategory) {
        numberOfItems = 2;
    }
    else
    {
        numberOfItems = [listFunction count];
    }
    return numberOfItems;
}


- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"CollectionViewCell";
    PSUICollectionViewCell *cell = nil;
    
    if (collectionView == (PSUICollectionView*)self.collectionViewCategory) {
        cellIdentifier = @"cellListCategory";
        cell = (PSUICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
        NSDictionary *dicItems = [list_categories objectAtIndex:indexPath.row];
        
        UILabel *label = (UILabel *)[cell viewWithTag:222];
        label.text = [dicItems objectForKey:@"cate_name"];
        
        UIImageView *imageiCon = (UIImageView *)[cell viewWithTag:111];
        [imageiCon setImageWithURL:[dicItems objectForKey:@"cate_image_url"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else
    {
        cellIdentifier = @"CollectionViewCell";
        cell = (PSUICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
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
    }
    
    
    return cell;
}

- (PSUICollectionReusableView *)collectionView:(PSUICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = nil;
	
    PSUICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    // TODO Setup view
    return supplementaryView;
}

#pragma mark Delegete crollview

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.collectionViewFunction.frame.size.width;
    self.pageControl.currentPage = (scrollView.contentOffset.y / pageWidth);
}

#pragma mark Swipe Gesture

-(void)handleSwipeGesture:(UISwipeGestureRecognizer *) sender
{
    //Gesture detect - swipe up/down , can be recognized direction
    if ( sender.direction == UISwipeGestureRecognizerDirectionLeft )
        NSLog(@" *** SWIPE LEFT ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionRight )
        NSLog(@" *** SWIPE RIGHT ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionDown )
        NSLog(@" *** SWIPE DOWN ***");
    if ( sender.direction == UISwipeGestureRecognizerDirectionUp )
        NSLog(@" *** SWIPE UP ***");
}

@end
