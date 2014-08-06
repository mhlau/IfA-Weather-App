//
//  SunMoonCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/30/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SunMoonCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (strong, nonatomic) IBOutlet UILabel *sunriseTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (strong, nonatomic) IBOutlet UILabel *sunsetTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *moonriseLabel;
@property (strong, nonatomic) IBOutlet UILabel *moonriseTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *moonsetLabel;
@property (strong, nonatomic) IBOutlet UILabel *moonsetTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *illumLabel;
@property (strong, nonatomic) IBOutlet UILabel *illumValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *cycleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cycleStateLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)sunriseTime :(NSNumber *)sunsetTime :(NSNumber *)moonriseTime :(NSNumber *)moonsetTime :(NSNumber *)illum :(NSString *)cycle;

@end
