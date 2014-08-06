//
//  WindCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *windTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMSLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMPHLabel;
@property (strong, nonatomic) IBOutlet UILabel *windDirTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *windDirDirLabel;
@property (strong, nonatomic) IBOutlet UILabel *windDirDegLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMaxTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMaxMSLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMaxMPHLabel;
@property (strong, nonatomic) IBOutlet UILabel *windMaxTimeLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)wsMS :(NSNumber *)wsMPH :(NSString *)dir :(NSString *)dirDeg :(NSNumber *)maxMS :(NSNumber *)maxMPH :(NSNumber *)maxDate;

@end
