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
    self.contentView.backgroundColor = [UIColor clearColor];
    self.dewptTitleLabel.textColor = [UIColor blackColor];
    self.dewptValueLabel.textColor = [UIColor blackColor];

}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.dewptTitleLabel.textColor = [UIColor blackColor];
    self.dewptValueLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)dewpoint
{
    self.dewptValueLabel.text = [dewpoint isEqual:@"N/A"] ?
    [NSString stringWithFormat:@"%@", dewpoint] :
    [NSString stringWithFormat:@"%@ \u00B0F", dewpoint];
    self.clipsToBounds = YES;
}

@end
