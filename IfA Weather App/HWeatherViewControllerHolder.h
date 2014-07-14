//
//  HWeatherViewControllerHolder.h
//  IfA Weather App
//
//  Created by Micah Lau on 7/13/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface HWeatherViewControllerHolder : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
