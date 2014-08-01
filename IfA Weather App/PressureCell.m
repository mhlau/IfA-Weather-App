//
//  PressureCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "PressureCell.h"

@implementation PressureCell

@synthesize pressureTitleLabel, pressureValueLabel;

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
    self.pressureTitleLabel.textColor = [UIColor blackColor];
    self.pressureValueLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.pressureTitleLabel.textColor = [UIColor blackColor];
    self.pressureValueLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText :(NSNumber *)pressure
{
    self.pressureValueLabel.text = [NSString stringWithFormat:@"%@ millibars", pressure];
}

@end
