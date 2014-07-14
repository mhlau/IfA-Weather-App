//
//  DateCell.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateTitleHILabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTitleUTLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateHILabel;
@property (strong, nonatomic) IBOutlet UILabel *dateUTLabel;

-(void)expandReformat;

-(void)closeReformat;

-(void)formatNumbersAndSetText:(NSNumber *)dateHI :(NSNumber *)dateUT;

@end
