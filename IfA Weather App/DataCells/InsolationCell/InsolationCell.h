//
//  InsolationCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsolationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *insolationTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *insolationKWM2Label;
@property (strong, nonatomic) IBOutlet UILabel *insolationLPHLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)insoKWM2 :(NSNumber *)insoLPH;

@end
