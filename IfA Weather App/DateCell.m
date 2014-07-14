//
//  DateCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell

@synthesize dateTitleHILabel, dateTitleUTLabel, dateHILabel, dateUTLabel;

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
    self.dateTitleHILabel.textColor = [UIColor whiteColor];
    self.dateTitleUTLabel.textColor = [UIColor whiteColor];
    self.dateHILabel.textColor = [UIColor whiteColor];
    self.dateUTLabel.textColor = [UIColor whiteColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.dateTitleHILabel.textColor = [UIColor blackColor];
    self.dateTitleUTLabel.textColor = [UIColor blackColor];
    self.dateHILabel.textColor = [UIColor blackColor];
    self.dateUTLabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)dateHI :(NSNumber *)dateUT
{
    self.dateHILabel.text = [NSString stringWithFormat:@"%@", dateHI];
    self.dateUTLabel.text = [NSString stringWithFormat:@"%@", dateUT];
    self.clipsToBounds = YES;
}

@end
