//
//  PressureCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PressureCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *pressureTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *pressureValueLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText :(NSNumber *)pressure;

@end
