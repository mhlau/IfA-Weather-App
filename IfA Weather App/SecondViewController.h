//
//  SecondViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSArray *imageURLs;

-(void)setMaunaKea: (BOOL)isMaunaKea;
-(void)setInfrared: (BOOL)isInfrared;
-(void)setWaterVapor: (BOOL)isWaterVapor;
-(void)setVisible: (BOOL)isVisible;

@end
