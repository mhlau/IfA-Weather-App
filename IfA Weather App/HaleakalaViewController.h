//
//  HaleakalaViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 7/14/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface HaleakalaViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
