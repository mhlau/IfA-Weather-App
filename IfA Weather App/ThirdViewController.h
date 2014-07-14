//
//  ThirdViewController.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/30/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "DataParser.h"

@interface ThirdViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CPTPlotDataSource, DataParserProtocol>
{
    NSArray *plotData;
}

@property (nonatomic, strong) CPTGraphHostingView *temperatureHostView;
@property (nonatomic, strong) CPTGraphHostingView *pressureHostView;
@property (nonatomic, strong) CPTGraphHostingView *humidityHostView;
@property (nonatomic, strong) CPTGraphHostingView *windSpeedHostView;
@property (nonatomic, strong) CPTGraphHostingView *windDirectionHostView;
@property (nonatomic, strong) CPTGraphHostingView *visibilityHostView;
@property (nonatomic, strong) CPTGraphHostingView *insolationHostView;
@property (nonatomic, strong) CPTGraphHostingView *dewpointHostView;
@property NSUInteger pageIndex;

@end

