//
//  SunMoonCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/30/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "SunMoonCell.h"

@implementation SunMoonCell

@synthesize sunriseLabel, sunriseTimeLabel, sunsetLabel, sunsetTimeLabel, moonriseLabel, moonriseTimeLabel, moonsetLabel, moonsetTimeLabel, illumLabel, illumValueLabel, cycleLabel, cycleStateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)expandReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.sunriseLabel.textColor = [UIColor blackColor];
    self.sunriseTimeLabel.textColor = [UIColor blackColor];
    self.sunsetLabel.textColor = [UIColor blackColor];
    self.sunsetTimeLabel.textColor = [UIColor blackColor];
    self.moonriseLabel.textColor = [UIColor blackColor];
    self.moonriseTimeLabel.textColor = [UIColor blackColor];
    self.moonsetLabel.textColor = [UIColor blackColor];
    self.moonsetTimeLabel.textColor = [UIColor blackColor];
    self.illumLabel.textColor = [UIColor blackColor];
    self.illumValueLabel.textColor = [UIColor blackColor];
    self.cycleLabel.textColor = [UIColor blackColor];
    self.cycleStateLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.sunriseLabel.textColor = [UIColor blackColor];
    self.sunriseTimeLabel.textColor = [UIColor blackColor];
    self.sunsetLabel.textColor = [UIColor blackColor];
    self.sunsetTimeLabel.textColor = [UIColor blackColor];
    self.moonriseLabel.textColor = [UIColor blackColor];
    self.moonriseTimeLabel.textColor = [UIColor blackColor];
    self.moonsetLabel.textColor = [UIColor blackColor];
    self.moonsetTimeLabel.textColor = [UIColor blackColor];
    self.illumLabel.textColor = [UIColor blackColor];
    self.illumValueLabel.textColor = [UIColor blackColor];
    self.cycleLabel.textColor = [UIColor blackColor];
    self.cycleStateLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)sunriseTime :(NSNumber *)sunsetTime :(NSNumber *)moonriseTime :(NSNumber *)moonsetTime :(NSNumber *)illum :(NSString *)cycle
{
    self.sunriseTimeLabel.text = [NSString stringWithFormat:@"%@", sunriseTime];
    self.sunsetTimeLabel.text = [NSString stringWithFormat:@"%@", sunsetTime];
    self.moonriseTimeLabel.text = [NSString stringWithFormat:@"%@", moonriseTime];
    self.moonsetTimeLabel.text = [NSString stringWithFormat:@"%@", moonsetTime];
    self.illumValueLabel.text = [NSString stringWithFormat:@"%@%%", illum];
    self.cycleStateLabel.text = [NSString stringWithFormat:@"%@", cycle];
    self.clipsToBounds = YES;
}

@end
