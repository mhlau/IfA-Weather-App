//
//  InsolationCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
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
    self.insolationTitleLabel.textColor = [UIColor whiteColor];
    self.insolationKWM2Label.textColor = [UIColor whiteColor];
    self.insolationLPHLabel.textColor = [UIColor whiteColor];
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
    self.insolationKWM2Label.text = [NSString stringWithFormat:@"%@ kW / m\u00B2", insoKWM2];
    self.insolationLPHLabel.text = [NSString stringWithFormat:@"%@ Langley / hr", insoLPH];
    self.clipsToBounds = YES;
}

@end
