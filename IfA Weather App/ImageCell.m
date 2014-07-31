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

- (void)awakeFromNib
{
    // Get image URLs from appropriate .plist file in project.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HImages" ofType:@"plist"];
    NSDictionary *imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if (_isMaunaKea)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"MKImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else if (_isInfrared)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"InfraredImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else if (_isWaterVapor)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"WaterVaporImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else if (_isVisible)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"VisibleImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    // Set URLs in array.
    NSMutableArray *URLs = [NSMutableArray array];
    for (NSString *path in imagePaths[@"Remote"])
    {
        NSURL *URL = [NSURL URLWithString:path];
        if (URL)
        {
            [URLs addObject:URL];
        }
        else
        {
            NSLog(@"'%@' is not a valid URL", path);
        }
    }
    self.imageURLs = URLs;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(NSArray *)getImageURLs
{
    return self.imageURLs;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.bounds = CGRectMake(0,57,320,280);
    self.imageView.frame = CGRectMake(0,57,320,280);
    self.imageView.contentMode = UIViewContentModeRedraw;
}

@end
