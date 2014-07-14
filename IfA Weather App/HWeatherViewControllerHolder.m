//
//  HWeatherViewControllerHolder.m
//  IfA Weather App
//
//  Created by Micah Lau on 7/13/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "HWeatherViewControllerHolder.h"

@interface HWeatherViewControllerHolder ()

@end

@implementation HWeatherViewControllerHolder

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
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HPageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 40);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    /*
    if (index > 2) {
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
    */
    ViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HWeatherViewController"];
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = 0;
    /*
    if ([viewController isKindOfClass:[ViewController class]])
    {
        NSLog(@"Before viewController is ViewController");
        index = ((ViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[SecondViewController class]])
    {
        NSLog(@"Before viewController is SecondViewController");
        index = ((SecondViewController*) viewController).pageIndex;
    }
    else if ([viewController isKindOfClass:[ThirdViewController class]])
    {
        NSLog(@"Before viewController is ThirdViewController");
        index = ((ThirdViewController*) viewController).pageIndex;
    }
    if ((index == 0) || (index == NSNotFound)) {
        NSLog(@"Before index is %lu", (unsigned long)index);
        return nil;
    }
    index--;
    */
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = 0;
    /*
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
    if (index > 2)
    {
        return nil;
    }
    */
    NSLog(@"VC After: %@", [self viewControllerAtIndex:index]);
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
