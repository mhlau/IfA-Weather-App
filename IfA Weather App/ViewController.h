//
//  ViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/24/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataParser.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, DataParserProtocol>
{
    int selectedIndex;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;

- (void)setMaunaKea :(BOOL)isMaunaKea;

@end
