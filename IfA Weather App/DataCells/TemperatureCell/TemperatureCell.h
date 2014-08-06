//
//  TemperatureCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *temperatureTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureInFLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureInCLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureWCTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureWCInFLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureWCInCLabel;


-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)aveTemp :(NSNumber *)aveTempF :(NSNumber *)windChillC :(NSNumber *)windChillF;

@end
