//
//  MenuViewController.m
//  phongthuy
//
//  Created by TonyNguyen on 5/17/13.
//  Copyright (c) 2013 pitaya. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
	// Do any additional setup after loading the view.
    lblName.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    imageAvatar = nil;
    lblName = nil;
    [self setTableMenu:nil];
    [super viewDidUnload];
}

- (void)logout
{
    // Process logout facebook
}

#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRow = 0;
    if (section == 0 || section == 1) {
        numberOfRow = 2;
    }
    else if (section == 2)
    {
        numberOfRow = 3;
    }
    else
    {
        numberOfRow = 1;
    }
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"UITableViewCell";
	UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    if (indexPath.section == 0) {
        cellStyle = UITableViewCellStyleValue1;
        cellIdentifier = @"UITableViewCellStyleValue1";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {        
        cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                UIImageView *preImage = (UIImageView*)[self.view viewWithTag:111];
                if (preImage == nil) {
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 22.5, 20)];
                    image.image = [UIImage imageNamed:@"coin.png"];
                    image.tag = 111;
                    [cell.contentView addSubview:image];
                }
                
                UILabel *labelTemp = (UILabel*)[self.view viewWithTag:222];
                if (labelTemp == nil) {
                    UILabel *titleCoin = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150, 20)];
                    titleCoin.text = @"Coin";
                    titleCoin.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
                    titleCoin.backgroundColor = [UIColor clearColor];
                    titleCoin.tag = 222;
                    [cell.contentView addSubview:titleCoin];
                    
                    cell.detailTextLabel.text = @"1000";
                }
            }
            else
            {
                cell.textLabel.text = @"Nạp thêm coin";
                cell.textLabel.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
                [self addDisclosureIndicatorOnCell:cell];
            }
            break;
        case 1:
            cell.textLabel.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Bài viết";                
                [self addDisclosureIndicatorOnCell:cell];
            }
            else
            {
                cell.textLabel.text = @"Ứng dụng";
                [self addDisclosureIndicatorOnCell:cell];
            }
            break;
        case 2:
            cell.textLabel.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Ứng dụng phong thủy";
                [self addDisclosureIndicatorOnCell:cell];
            }
            else if(indexPath.row == 1)
            {
                cell.textLabel.text = @"Version 1.0";
                [self addDisclosureIndicatorOnCell:cell];
            }
            else
            {
                cell.textLabel.text = @"Điều khoản sử dụng";
                [self addDisclosureIndicatorOnCell:cell];
            }
            break;
        case 3:
            [self addButtonToCell:cell];
            break;
        default:
            break;
    }
    
    return cell;    
}

- (void)addButtonToCell:(UITableViewCell *)cell
{
    UIButton *btnTemp = (UIButton *)[self.view viewWithTag:333];
    if (btnTemp == nil) {
        UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogout.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [btnLogout setImage:[UIImage imageNamed:@"btn_LogoutFacebook.png"] forState:UIControlStateNormal];
        btnLogout.frame = CGRectMake(37, 2.5, 240, 35);
        btnLogout.tag = 333;
        [btnLogout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnLogout];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    if (section == 0) {
        title = @"TÀI KHOẢN";
    }
    else if (section == 1)
    {
        title = @"PHONG THỦY";
    }
    else if (section == 2)
    {
        title = @"GIỚI THIỆU";
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 300, 25)];
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 25)];
    lblHeader.text = title;
    lblHeader.font = [UIFont fontWithName:@"UVNTinTuc_B" size:18.0f];
    lblHeader.backgroundColor = [UIColor clearColor];
	lblHeader.opaque = NO;
	lblHeader.textColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];
	lblHeader.highlightedTextColor = [UIColor whiteColor];
    [headerView addSubview:lblHeader];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 0;
    }
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-----------------------------------------------------------------------------------
- (void)addDisclosureIndicatorOnCell:(UITableViewCell *)cell
//-----------------------------------------------------------------------------------
{
	UIImage *image = [UIImage imageNamed:@"arrow.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	cell.accessoryView = imageView;
	image = nil;
}
@end
