//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Modified by Micah Lau on 7/14/14.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController {
    NSArray *menuItems;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the color of the sidebar background (the part of the tableview without prototype cells).
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.05f alpha:0.2f];
    // Set the titles of the sidebar cells. MUST match cell Identifier in storyboard.
    menuItems = @[@"HaleakalaTitle", @"Haleakala Weather", @"Haleakala Images", @"Haleakala 24-Hour Trends", @"Haleakala 48-Hour Trends", @"MKTitle", @"Mauna Kea Weather", @"Mauna Kea Images", @"Mauna Kea Satellite Images", @"Mauna Kea 24-Hour Trends", @"Mauna Kea 48-Hour Trends"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Set the title of navigation bar by using the menu items.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    // Perform the segue; use conditionals to switch between Haleakala and MK:
    if ([segue isKindOfClass: [SWRevealViewControllerSegue class]])
    {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        swSegue.performBlock = ^(SWRevealViewControllerSegue *rvc_segue, UIViewController *svc, UIViewController *dvc)
            {
                // Set SecondVC to download MK images if MK cell is tapped.
                if ([dvc isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"MKImageSegue"])
                {
                    [(SecondViewController *)dvc setMaunaKea:true];
                }
                // Set SecondVC to download MK images if MK cell is tapped.
                if ([segue.identifier isEqualToString:@"MKSatelliteSegue"])
                {
                    SecondViewController *dvc = (SecondViewController *)([[segue.destinationViewController viewControllers] objectAtIndex:0]);
                    SecondViewController *dvc2 = (SecondViewController *)([[segue.destinationViewController viewControllers] objectAtIndex:1]);
                    [(SecondViewController *)dvc setSatellite:true];
                    [(SecondViewController *)dvc2 setWaterVapor:true];
                }
                // Set ThirdVC to download 48-hour data if 48-hour cell is tapped.
                if ([dvc isKindOfClass:[ThirdViewController class]] && [segue.identifier isEqualToString:@"H48GraphSegue"])
                {
                    [(ThirdViewController *)dvc set48Hours:true];
                }
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
    }
}

@end
