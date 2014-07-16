//
//  ImageCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface ImageCell : UITableViewCell

@property (nonatomic, strong) NSArray *imageURLs;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

-(NSArray *)getImageURLs;

@end
