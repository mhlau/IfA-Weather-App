//
//  SidebarViewController.m
//  SidebarDemo
//
//  Modified from AppCoda by Micah Lau on 6/24/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A class for the Sidebar View Controller. Uses cell identifiers and segues defined in storyboard
//  for app navigation between views (UIViewControllers).
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
    // Set the titles of the sidebar cells. MUST EXACTLY MATCH cell Identifier in storyboard.
    menuItems = @[@"Haleakala Title",
                  @"Haleakala Weather",
                  @"Haleakala Images",
                  @"Haleakala 24-Hour Trends",
                  @"Haleakala 48-Hour Trends",
                  @"Mauna Kea Title",
                  @"Mauna Kea Weather",
                  @"Mauna Kea Images",
                  @"Mauna Kea 24-Hour Trends",
                  @"Mauna Kea Forecast",
                  @"Satellite Title",
                  @"Infrared",
                  @"Water Vapor",
                  @"Visible",
                  @"Animations"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Make the sidebar return to original position when it is closed.
    self.view = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get cell identifier from menuItems (matching cell identifiers in storyboard).
    NSString *cellIdentifier = [menuItems objectAtIndex:indexPath.row];
    // Create cell at row using cell identifier.
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
        swSegue.performBlock = ^(SWRevealViewControllerSegue *rearVCSegue, UIViewController *sideVC, UIViewController *destVC)
            {
                // Haleakala 48 Hour Trends cell is selected:
                if ([destVC isKindOfClass:[ThirdViewController class]] && [segue.identifier isEqualToString:@"H48GraphSegue"])
                {
                    [(ThirdViewController *)destVC set48Hours:true];
                }
                // Mauna Kea Weather cell is selected:
                else if ([destVC isKindOfClass:[ViewController class]] && [segue.identifier isEqualToString:@"MKWeatherSegue"])
                {
                    [(ViewController *)destVC setMaunaKea:true];
                }
                // Mauna Kea Images cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"MKImageSegue"])
                {
                    [(SecondViewController *)destVC setMaunaKea:true];
                }
                // Mauna Kea 24 Hour Trends cell is selcted:
                else if ([destVC isKindOfClass:[ThirdViewController class]] && [segue.identifier isEqualToString:@"MK24GraphSegue"])
                {
                    [(ThirdViewController *)destVC setMaunaKea:true];
                }
                // Infrared Images cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"InfraredSegue"])
                {
                    [(SecondViewController *)destVC setInfrared:true];
                }
                // Water Vapor Images cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"WaterVaporSegue"])
                {
                    [(SecondViewController *)destVC setWaterVapor:true];
                }
                // Visible Weather Images cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"VisibleSegue"])
                {
                    [(SecondViewController *)destVC setVisible:true];
                }
                // Animated Images cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"AnimationSegue"])
                {
                    [(SecondViewController *)destVC setAnimation:true];
                }
                // Forecast Image cell is selected:
                else if ([destVC isKindOfClass:[SecondViewController class]] && [segue.identifier isEqualToString:@"MKForecastSegue"])
                {
                    [(SecondViewController *)destVC setForecast:true];
                }
            // Switch from previous ViewController to destination view controller.
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[destVC] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
            };
    }
}

@end
