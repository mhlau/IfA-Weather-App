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
    BOOL _isSatellite;
    BOOL _isWaterVapor;
}
@end

@implementation ImageCell

@synthesize locationLabel;

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

-(void)setSatellite: (BOOL)isSatellite
{
    _isSatellite = isSatellite;
}

-(void)setWaterVapor: (BOOL)isWaterVapor
{
    _isWaterVapor = isWaterVapor;
}

- (void)awakeFromNib
{
    // Get image URLs from appropriate .plist file in project.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    NSDictionary *imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    if (_isMaunaKea)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"MKImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else if (_isSatellite)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"MKSatelliteImages" ofType:@"plist"];
        imagePaths = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    else if (_isWaterVapor)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"MKWaterVaporImages" ofType:@"plist"];
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

@end
