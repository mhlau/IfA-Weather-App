//
//  VisibilityCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/27/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisibilityCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *visTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *visMLabel;
@property (strong, nonatomic) IBOutlet UILabel *visKMLabel;
@property (strong, nonatomic) IBOutlet UILabel *visFTLabel;
@property (strong, nonatomic) IBOutlet UILabel *visMILabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)visM :(NSNumber *)visKM :(NSNumber *)visFT :(NSNumber *)visMI;

@end
