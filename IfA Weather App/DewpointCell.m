//
//  DewpointCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "DewpointCell.h"

@implementation DewpointCell

@synthesize dewptTitleLabel, dewptValueLabel;

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
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.dewptTitleLabel.textColor = [UIColor whiteColor];
    self.dewptValueLabel.textColor = [UIColor whiteColor];

}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.dewptTitleLabel.textColor = [UIColor blackColor];
    self.dewptValueLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)dewpoint
{
    self.dewptValueLabel.text = [NSString stringWithFormat:@"%@ \u00B0F", dewpoint];
    self.clipsToBounds = YES;
}

@end
