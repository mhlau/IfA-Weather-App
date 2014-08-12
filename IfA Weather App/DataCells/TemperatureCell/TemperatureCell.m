//
//  TemperatureCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A class for displaying the current temperature in ViewController.
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
    self.temperatureInFLabel.text = [aveTempF isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", aveTempF] :
    [NSString stringWithFormat:@"%@ %@", aveTempF, @"\u00B0F"];
    self.temperatureInCLabel.text = [aveTemp isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", aveTemp] :
    [NSString stringWithFormat:@"%@ %@", aveTemp, @"\u00B0C"];
    self.temperatureWCInFLabel.text = [windChillF isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", windChillF] :
    [NSString stringWithFormat:@"%@ %@", windChillF, @"\u00B0F"];
    self.temperatureWCInCLabel.text = [windChillC isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", windChillC] :
    [NSString stringWithFormat:@"%@ %@", windChillC, @"\u00B0C"];
}

@end
