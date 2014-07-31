//
//  ImageCell.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
{
    BOOL _isMaunaKea;
    BOOL _isInfrared;
    BOOL _isWaterVapor;
    BOOL _isVisible;
}
@end

@implementation ImageCell

@synthesize locationLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)setMaunaKea: (BOOL)isMaunaKea
{
    _isMaunaKea = isMaunaKea;
}

-(void)setInfrared: (BOOL)isInfrared
{
    _isInfrared = isInfrared;
}

-(void)setWaterVapor: (BOOL)isWaterVapor
{
    _isWaterVapor = isWaterVapor;
}

-(void)setVisible: (BOOL)isVisible
{
    _isVisible = isVisible;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0,57,320,280);
    self.imageView.frame = CGRectMake(0,57,320,280);
    self.imageView.contentMode = UIViewContentModeRedraw;
}

@end
