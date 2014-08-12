//
//  InsolationCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A class for displaying the current insolation in ViewController.
//

#import "InsolationCell.h"

@implementation InsolationCell

@synthesize insolationTitleLabel, insolationKWM2Label, insolationLPHLabel;

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
    self.insolationTitleLabel.textColor = [UIColor blackColor];
    self.insolationKWM2Label.textColor = [UIColor blackColor];
    self.insolationLPHLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.insolationTitleLabel.textColor = [UIColor blackColor];
    self.insolationKWM2Label.textColor = [UIColor blackColor];
    self.insolationLPHLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)insoKWM2 :(NSNumber *)insoLPH
{
    self.insolationKWM2Label.text = [insoKWM2 isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", insoKWM2] :
    [NSString stringWithFormat:@"%@ kW / m\u00B2", insoKWM2];
    self.insolationLPHLabel.text = [insoLPH isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", insoLPH] :
    [NSString stringWithFormat:@"%@ Langley / hr", insoLPH];
}

@end
