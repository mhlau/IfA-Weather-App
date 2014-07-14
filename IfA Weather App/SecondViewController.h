//
//  SecondViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *imageURLs;
@property NSUInteger pageIndex;

@end
