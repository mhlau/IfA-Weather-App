//
//  DateCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A class for displaying the current date and time in ViewController.
//

#import "DateCell.h"

@implementation DateCell

@synthesize dateTitleHILabel, dateTitleUTLabel, dateHILabel, dateUTLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)expandReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.dateTitleHILabel.textColor = [UIColor blackColor];
    self.dateTitleUTLabel.textColor = [UIColor blackColor];
    self.dateHILabel.textColor = [UIColor blackColor];
    self.dateUTLabel.textColor = [UIColor blackColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.dateTitleHILabel.textColor = [UIColor blackColor];
    self.dateTitleUTLabel.textColor = [UIColor blackColor];
    self.dateHILabel.textColor = [UIColor blackColor];
    self.dateUTLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)dateHI :(NSNumber *)dateUT
{
    self.dateHILabel.text = [NSString stringWithFormat:@"%@", dateHI];
    self.dateUTLabel.text = [NSString stringWithFormat:@"%@", dateUT];
}

@end
