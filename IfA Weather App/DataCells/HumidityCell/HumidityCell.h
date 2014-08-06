//
//  HumidityCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HumidityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *humidityTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityValueLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)humidity;

@end
