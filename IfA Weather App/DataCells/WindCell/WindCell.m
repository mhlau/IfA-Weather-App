//
//  WindCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "WindCell.h"

@implementation WindCell

@synthesize windTitleLabel, windMSLabel, windMPHLabel, windDirTitleLabel, windDirDirLabel,windDirDegLabel, windMaxTitleLabel, windMaxMSLabel, windMaxMPHLabel, windMaxTimeLabel;

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
    self.windTitleLabel.textColor = [UIColor blackColor];
    self.windMSLabel.textColor = [UIColor blackColor];
    self.windMPHLabel.textColor = [UIColor blackColor];
    self.windDirTitleLabel.textColor = [UIColor blackColor];
    self.windDirDirLabel.textColor = [UIColor blackColor];
    self.windDirDegLabel.textColor = [UIColor blackColor];
    self.windMaxTitleLabel.textColor = [UIColor blackColor];
    self.windMaxMSLabel.textColor = [UIColor blackColor];
    self.windMaxMPHLabel.textColor = [UIColor blackColor];
    self.windMaxTimeLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.windTitleLabel.textColor = [UIColor blackColor];
    self.windMSLabel.textColor = [UIColor blackColor];
    self.windMPHLabel.textColor = [UIColor blackColor];
    self.windDirTitleLabel.textColor = [UIColor blackColor];
    self.windDirDirLabel.textColor = [UIColor blackColor];
    self.windDirDegLabel.textColor = [UIColor blackColor];
    self.windMaxTitleLabel.textColor = [UIColor blackColor];
    self.windMaxMSLabel.textColor = [UIColor blackColor];
    self.windMaxMPHLabel.textColor = [UIColor blackColor];
    self.windMaxTimeLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)wsMS :(NSNumber *)wsMPH :(NSString *)dir :(NSString *)dirDeg :(NSNumber *)maxMS :(NSNumber *)maxMPH :(NSNumber *)maxDate
{
    self.windMSLabel.text = [wsMS isEqual:@"N/A"] ?
        [NSString stringWithFormat:@"%@", wsMS] :
        [NSString stringWithFormat:@"%@ m/s", wsMS];
    self.windMPHLabel.text = [wsMS isEqual:@"N/A"] ?
        [NSString stringWithFormat:@"%@", wsMPH] :
        [NSString stringWithFormat:@"%@ mph", wsMPH];
    self.windDirDirLabel.text = [NSString stringWithFormat:@"%@", dir];
    self.windDirDegLabel.text = [dirDeg isEqual:@"N/A"] ?
        @"Degrees N/A" :
        [NSString stringWithFormat:@"%@", dirDeg];
    self.windMaxMSLabel.text = [maxMS isEqual:@"N/A"] ?
        [NSString stringWithFormat:@"%@", maxMS] :
        [NSString stringWithFormat:@"%@ m/s", maxMS];
    self.windMaxMPHLabel.text = [maxMPH isEqual:@"N/A"] ?
        [NSString stringWithFormat:@"%@", maxMPH] :
        [NSString stringWithFormat:@"%@ mph", maxMPH];
    self.windMaxTimeLabel.text = [NSString stringWithFormat:@"%@ UT", maxDate];
}

@end
