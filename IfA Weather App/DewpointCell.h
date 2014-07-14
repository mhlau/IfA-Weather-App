//
//  DewpointCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DewpointCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *dewptTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *dewptValueLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)dewpoint;

@end
