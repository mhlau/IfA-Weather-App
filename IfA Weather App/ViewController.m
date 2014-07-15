//
//  FirstViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/24/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "ViewController.h"
#import "DateCell.h"
#import "TemperatureCell.h"
#import "HumidityCell.h"
#import "InsolationCell.h"
#import "VisibilityCell.h"
#import "WindCell.h"
#import "PressureCell.h"
#import "DewpointCell.h"
#import "SunMoonCell.h"
#import "SWRevealViewController.h"

@interface ViewController ()
{
    DataParser *_dataParser;
    NSMutableDictionary *_dataDict;
    NSTimer *_timer;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

// Changes the style of the status bar.
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    selectedIndex = -1;
    _dataDict = [[NSMutableDictionary alloc] init];
    _dataParser = [[DataParser alloc] init];
    _dataParser.delegate = self;
    [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/currentweather.php"];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //unload view to demonstrate caching
    self.view = nil;
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSDictionary *)itemDict
{
    // This delegate method will get called when the items are finished downloading.
    // First, round any decimals to 2 places. Then add downloaded item to dictionary.
    [_dataDict removeAllObjects];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setMaximumFractionDigits:2];
    [numFormatter setRoundingMode: NSNumberFormatterRoundDown];
    for (id key in itemDict)
    {
        if ([[itemDict objectForKey:key] isKindOfClass:[NSNumber class]])
        {
            float floatValue = [[itemDict objectForKey:key] floatValue];
            NSString *newValue = [numFormatter stringFromNumber:[NSNumber numberWithFloat:floatValue]];
            [_dataDict setObject:newValue forKey:key];
        }
        else
        {
            [_dataDict setObject:[itemDict objectForKey:key] forKey:key];
        }
    }
    [self.tableView reloadData];
}

-(void)reloadData
{
    [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/currentweather.php"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // DATE (ROW 0)
    if (indexPath.row == 0) {
        // Initialize DateCell and load NIB.
        DateCell *dateCell = (DateCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingDateCell"];
        if (dateCell == nil)
        {
            NSArray *dateNIB = [[NSBundle mainBundle] loadNibNamed:@"DateCell" owner:self options:nil];
            dateCell = [dateNIB objectAtIndex:0];
        }
        // Reformat cell on selection.
        if (selectedIndex == indexPath.row)
        {
            [dateCell expandReformat];
        }
        else
        {
            [dateCell closeReformat];
        }
        // Format values from data dictionary, and set them as text in labels.
        [dateCell formatNumbersAndSetText:_dataDict[@"date_HI"] :_dataDict[@"date_UT"]];
        return dateCell;
    }
    // TEMPERATURE (ROW 1)
    else if (indexPath.row == 1)
    {
        TemperatureCell *tempCell = (TemperatureCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingTemperatureCell"];
        if (tempCell == nil)
        {
            NSArray *tempNIB = [[NSBundle mainBundle] loadNibNamed:@"TemperatureCell" owner:self options:nil];
            tempCell = [tempNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [tempCell expandReformat];
        }
        else
        {
            [tempCell closeReformat];
        }
        [tempCell formatNumbersAndSetText:_dataDict[@"ave_temperature"]:_dataDict[@"ave_temperature_F"] :_dataDict[@"wind_chill_C"]  :_dataDict[@"wind_chill_F"]];
        return tempCell;
    }
    // HUMIDITY (ROW 2)
    else if (indexPath.row == 2)
    {
        HumidityCell *humidCell = (HumidityCell *)[tableView dequeueReusableCellWithIdentifier:@"humidityCell"];
        if (humidCell == nil)
        {
            NSArray *humidNIB = [[NSBundle mainBundle] loadNibNamed:@"HumidityCell" owner:self options:nil];
            humidCell = [humidNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [humidCell expandReformat];
        }
        else
        {
            [humidCell closeReformat];
        }
        [humidCell formatNumbersAndSetText:_dataDict[@"ave_humidity"]];
        return humidCell;
    }
    // INSOLATION (ROW 3)
    else if (indexPath.row == 3)
    {
        InsolationCell *insolationCell = (InsolationCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingInsolationCell"];
        if (insolationCell == nil)
        {
            NSArray *insoNIB = [[NSBundle mainBundle] loadNibNamed:@"InsolationCell" owner:self options:nil];
            insolationCell = [insoNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [insolationCell expandReformat];
        }
        else
        {
            [insolationCell closeReformat];
        }
        [insolationCell formatNumbersAndSetText:_dataDict[@"ave_insolation_kWm2"]:_dataDict[@"ave_insolation"]];
        return insolationCell;
    }
    // VISIBILITY (ROW 4)
    else if (indexPath.row == 4)
    {
        VisibilityCell *visCell = (VisibilityCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingVisibilityCell"];
        if (visCell == nil)
        {
            NSArray *visNIB = [[NSBundle mainBundle] loadNibNamed:@"VisibilityCell" owner:self options:nil];
            visCell = [visNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [visCell expandReformat];
        }
        else
        {
            [visCell closeReformat];
        }
        [visCell formatNumbersAndSetText:_dataDict[@"ave_visibility"]:_dataDict[@"ave_visibility_km"]:_dataDict[@"ave_visibility_ft"]:_dataDict[@"ave_visibility_mi"]];
        return visCell;
    }
    // WIND (ROW 5)
    else if (indexPath.row == 5)
    {
        WindCell *windCell = (WindCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingWindCell"];
        if (windCell == nil)
        {
            NSArray *windNIB = [[NSBundle mainBundle] loadNibNamed:@"WindCell" owner:self options:nil];
            windCell = [windNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [windCell expandReformat];
        }
        else
        {
            [windCell closeReformat];
        }
        [windCell formatNumbersAndSetText:_dataDict[@"ave_wind_speed_ms"]:_dataDict[@"wind_speed_mph"]:_dataDict[@"wind_dir"]:_dataDict[@"ave_wind_dir"]:_dataDict[@"max_wind_speed_ms"]:_dataDict[@"max_wind_speed_mph"]:_dataDict[@"max_wind_speed_time"]];
        return windCell;
    }
    // PRESSURE (ROW 6)
    else if (indexPath.row == 6)
    {
        PressureCell *pressCell = (PressureCell *)[tableView dequeueReusableCellWithIdentifier:@"pressureCell"];
        if (pressCell == nil)
        {
            NSArray *pressNIB = [[NSBundle mainBundle] loadNibNamed:@"PressureCell" owner:self options:nil];
            pressCell = [pressNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [pressCell expandReformat];
        }
        else
        {
            [pressCell closeReformat];
        }
        [pressCell formatNumbersAndSetText:_dataDict[@"ave_pressure"]];
        return pressCell;
    }
    // DEWPOINT (ROW 7)
    else if (indexPath.row == 7)
    {
        DewpointCell *dewCell = (DewpointCell *)[tableView dequeueReusableCellWithIdentifier:@"dewpointCell"];
        if (dewCell == nil)
        {
            NSArray *dewNIB = [[NSBundle mainBundle] loadNibNamed:@"DewpointCell" owner:self options:nil];
            dewCell = [dewNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [dewCell expandReformat];
        }
        else
        {
            [dewCell closeReformat];
        }
        [dewCell formatNumbersAndSetText:_dataDict[@"ave_dewpoint"]];
        return dewCell;
    }
    // SUN AND MOON (ROW 8)
    else
    {
        SunMoonCell *sunMoonCell = (SunMoonCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingSunMoonCell"];
        if (sunMoonCell == nil)
        {
            NSArray *sunMoonNIB = [[NSBundle mainBundle] loadNibNamed:@"SunMoonCell" owner:self options:nil];
            sunMoonCell = [sunMoonNIB objectAtIndex:0];
        }
        if (selectedIndex == indexPath.row)
        {
            [sunMoonCell expandReformat];
        }
        else
        {
            [sunMoonCell closeReformat];
        }
        [sunMoonCell formatNumbersAndSetText:_dataDict[@"sunrise"]:_dataDict[@"sunset"]:_dataDict[@"moonrise"]:_dataDict[@"moonset"]:_dataDict[@"illum"]:_dataDict[@"segment"]];
        return sunMoonCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If row is selected, expand it to its unique cell height.
    if ((selectedIndex == indexPath.row) && (selectedIndex == 0)) { return 90; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 1)) { return 155; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 2)) { return 50; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 3)) { return 80; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 4)) { return 85; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 5)) { return 270; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 6)) { return 50; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 7)) { return 50; }
    if ((selectedIndex == indexPath.row) && (selectedIndex == 8)) { return 240; }
    // All closed cells have default height of 50.
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // User taps expanded row:
    if (selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    // User taps different row:
    if (selectedIndex != -1)
    {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    // User taps new row with none expanded:
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
