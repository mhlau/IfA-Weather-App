//
//  HaleakalaViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 7/14/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "HaleakalaViewController.h"

@interface HaleakalaViewController ()

@end

@implementation HaleakalaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HPageViewController"];
    self.pageViewController.dataSource = self;
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = 0;
    if ([viewController isKindOfClass:[ViewController class]])
    {
        index = ((ViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[SecondViewController class]])
    {
        index = ((SecondViewController*) viewController).pageIndex;
    }
    else
    {
        index = ((ThirdViewController*) viewController).pageIndex;
    }
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = 0;
    if ([viewController isKindOfClass:[ViewController class]])
    {
        index = ((ViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[SecondViewController class]])
    {
        index = ((SecondViewController*) viewController).pageIndex;
    }
    else
    {
        index = ((ThirdViewController*) viewController).pageIndex;
    }
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == 3) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 3) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    if (index == 0)
    {
        ViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HWeatherViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
    else if (index == 1)
    {
        SecondViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HImageViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
    else
    {
        ThirdViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HGraphViewController"];
        pageContentViewController.pageIndex = index;
        return pageContentViewController;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
