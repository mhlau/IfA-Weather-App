//
//  VisibilityCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "VisibilityCell.h"

@implementation VisibilityCell

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
    self.visTitleLabel.textColor = [UIColor whiteColor];
    self.visMLabel.textColor = [UIColor whiteColor];
    self.visKMLabel.textColor = [UIColor whiteColor];
    self.visFTLabel.textColor = [UIColor whiteColor];
    self.visMILabel.textColor = [UIColor whiteColor];
}

-(void)closeReformat
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.visTitleLabel.textColor = [UIColor blackColor];
    self.visMLabel.textColor = [UIColor blackColor];
    self.visKMLabel.textColor = [UIColor blackColor];
    self.visFTLabel.textColor = [UIColor blackColor];
    self.visMILabel.textColor = [UIColor blackColor];
}

-(void)formatNumbersAndSetText:(NSNumber *)visM :(NSNumber *)visKM :(NSNumber *)visFT :(NSNumber *)visMI
{
    self.visMLabel.text = [NSString stringWithFormat:@"%@ m", visM];
    self.visKMLabel.text = [NSString stringWithFormat:@"%@ km", visKM];
    self.visFTLabel.text = [NSString stringWithFormat:@"%@ ft", visFT];
    self.visMILabel.text = [NSString stringWithFormat:@"%@ mi", visMI];
    self.clipsToBounds = YES;
}

@end
