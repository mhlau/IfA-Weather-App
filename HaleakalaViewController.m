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
    ViewController *startingViewController = [self viewControllerAtIndex:0];
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
    NSLog(@"1");
    NSUInteger index = ((ViewController*) viewController).pageIndex;
    NSLog(@"2");

    if ((index == 0) || (index == NSNotFound)) {
        NSLog(@"3");

        return nil;
    }
    NSLog(@"4");

    index--;
    NSLog(@"5");

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"6");

    NSUInteger index = ((ViewController*) viewController).pageIndex;
    NSLog(@"7");

    if (index == NSNotFound) {
        NSLog(@"8");

        return nil;
    }
    NSLog(@"9");

    index++;
    NSLog(@"10");

    if (index == 3) {
        NSLog(@"11");

        return nil;
    }
    NSLog(@"12");

    return [self viewControllerAtIndex:index];
}

- (ViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 3) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    ViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HWeatherViewController"];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
