//
//  LocationCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 8/1/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;

-(void)formatNumbersAndSetText:(NSString *)location;

@end
