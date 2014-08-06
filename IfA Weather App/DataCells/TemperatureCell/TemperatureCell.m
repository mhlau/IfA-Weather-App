//
//  TemperatureCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "TemperatureCell.h"

@implementation TemperatureCell

@synthesize temperatureTitleLabel, temperatureInFLabel, temperatureInCLabel, temperatureWCTitleLabel, temperatureWCInFLabel, temperatureWCInCLabel;

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
    self.temperatureTitleLabel.textColor = [UIColor blackColor];
    self.temperatureInFLabel.textColor = [UIColor blackColor];
    self.temperatureInCLabel.textColor = [UIColor blackColor];
    self.temperatureWCTitleLabel.textColor = [UIColor blackColor];
    self.temperatureWCInFLabel.textColor = [UIColor blackColor];
    self.temperatureWCInCLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.temperatureTitleLabel.textColor = [UIColor blackColor];
    self.temperatureInFLabel.textColor = [UIColor blackColor];
    self.temperatureInCLabel.textColor = [UIColor blackColor];
    self.temperatureWCTitleLabel.textColor = [UIColor blackColor];
    self.temperatureWCInFLabel.textColor = [UIColor blackColor];
    self.temperatureWCInCLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)aveTemp :(NSNumber *)aveTempF :(NSNumber *)windChillC :(NSNumber *)windChillF
{
    self.temperatureInFLabel.text = [NSString stringWithFormat:@"%@ %@", aveTempF, @"\u00B0F"];
    self.temperatureInCLabel.text = [NSString stringWithFormat:@"%@ %@", aveTemp, @"\u00B0C"];
    self.temperatureWCInFLabel.text = [NSString stringWithFormat:@"%@ %@", windChillF, @"\u00B0F"];
    self.temperatureWCInCLabel.text = [NSString stringWithFormat:@"%@ %@", windChillC, @"\u00B0C"];
}

@end
