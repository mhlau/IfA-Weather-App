//
//  SettingsViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 8/4/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdViewController.h"

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) IBOutlet UISwitch *timeSwitch;

-(IBAction)toggleTime:(UISwitch *)sender;

@end
