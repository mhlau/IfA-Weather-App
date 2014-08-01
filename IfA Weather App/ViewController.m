//
//  ViewController.m
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
    BOOL _isMaunaKea;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up background image.
    UIImage *background = [UIImage imageNamed:@"haleakalamorning.jpg"];
    self.navigationItem.title = @"Haleakala Weather";
    if (_isMaunaKea)
    {
        background = [UIImage imageNamed:@"maunakeamorning.jpg"];
        self.navigationItem.title = @"Mauna Kea Weather";
    }
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    [self.view sendSubviewToBack:self.backgroundImageView];
    
    // Set title here, because Haleakala ViewController is first to load.
    // Set up tableView as DataParser datasource and delegate.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // No index is selected when view first loads.
    selectedIndex = -1;
    
    // Initialize DataParser and supporting data structures. Download the data.
    _dataDict = [[NSMutableDictionary alloc] init];
    _dataParser = [[DataParser alloc] init];
    _dataParser.delegate = self;
    if (_isMaunaKea)
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/MKCurrentWeather.php"];
    }
    else
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HCurrentWeather.php"];
    }
    
    // Initialize NSTimer that ticks every second, reloading data on each tick.
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
    
    // Set up the sidebar.
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)setMaunaKea :(BOOL)isMaunaKea
{
    _isMaunaKea = isMaunaKea;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // Set the bounds and frame for the background image.
    CGRect bounds = self.view.bounds;
    self.backgroundImageView.frame = bounds;
    self.tableView.frame = bounds;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
    // Stop the timer when the user switches away from this view.
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)itemsDownloaded:(NSDictionary *)itemDict
{
    // This delegate method will get called when the items are finished downloading.
    [_dataDict removeAllObjects];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setMaximumFractionDigits:2];
    [numFormatter setRoundingMode: NSNumberFormatterRoundDown];
    for (id key in itemDict)
    {
        // If the object is a number, round it first. Then add it to the data dictionary.
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
    // Download the data again (from the respective URL).
    if (_isMaunaKea)
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/MKCurrentWeather.php"];
    }
    else
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HCurrentWeather.php"];
    }
}

#pragma mark UITableView methods
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
        dateCell.clipsToBounds = YES;
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
        if (_dataDict[@"date_HI"])
        {
            [dateCell formatNumbersAndSetText:_dataDict[@"date_HI"] :_dataDict[@"date_UT"]];
        }
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
        tempCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [tempCell expandReformat];
        }
        else
        {
            [tempCell closeReformat];
        }
        if (_isMaunaKea && _dataDict[@"temperature"])
        {
            [tempCell formatNumbersAndSetText:_dataDict[@"temperature"] :_dataDict[@"temperature_F"] :nil :nil];
        }
        else if (_dataDict[@"ave_temperature"])
        {
            [tempCell formatNumbersAndSetText:_dataDict[@"ave_temperature"]:_dataDict[@"ave_temperature_F"] :_dataDict[@"wind_chill_C"]  :_dataDict[@"wind_chill_F"]];
        }
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
        humidCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [humidCell expandReformat];
        }
        else
        {
            [humidCell closeReformat];
        }
        if (_isMaunaKea && _dataDict[@"humidity"])
        {
            [humidCell formatNumbersAndSetText:_dataDict[@"humidity"]];
        }
        else if (_dataDict[@"ave_humidity"])
        {
            [humidCell formatNumbersAndSetText:_dataDict[@"ave_humidity"]];
        }
        return humidCell;
    }
    // INSOLATION (ROW 3) (Not in MK)
    else if (indexPath.row == 3 && !_isMaunaKea)
    {
        InsolationCell *insolationCell = (InsolationCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingInsolationCell"];
        if (insolationCell == nil)
        {
            NSArray *insoNIB = [[NSBundle mainBundle] loadNibNamed:@"InsolationCell" owner:self options:nil];
            insolationCell = [insoNIB objectAtIndex:0];
        }
        insolationCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [insolationCell expandReformat];
        }
        else
        {
            [insolationCell closeReformat];
        }
        if (_dataDict[@"ave_insolation_kWm2"])
        {
            [insolationCell formatNumbersAndSetText:_dataDict[@"ave_insolation_kWm2"]:_dataDict[@"ave_insolation"]];
        }
        return insolationCell;
    }
    // VISIBILITY (ROW 4) (Not in MK)
    else if (indexPath.row == 4 && !_isMaunaKea)
    {
        VisibilityCell *visCell = (VisibilityCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingVisibilityCell"];
        if (visCell == nil)
        {
            NSArray *visNIB = [[NSBundle mainBundle] loadNibNamed:@"VisibilityCell" owner:self options:nil];
            visCell = [visNIB objectAtIndex:0];
        }
        visCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [visCell expandReformat];
        }
        else
        {
            [visCell closeReformat];
        }
        if (_dataDict[@"ave_visibility"])
        {
            [visCell formatNumbersAndSetText:_dataDict[@"ave_visibility"]:_dataDict[@"ave_visibility_km"]:_dataDict[@"ave_visibility_ft"]:_dataDict[@"ave_visibility_mi"]];
        }
        return visCell;
    }
    // WIND (ROW 5) (ROW 3 in MK)
    else if ((indexPath.row == 5 && !_isMaunaKea) || (_isMaunaKea && indexPath.row == 3))
    {
        WindCell *windCell = (WindCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingWindCell"];
        if (windCell == nil)
        {
            NSArray *windNIB = [[NSBundle mainBundle] loadNibNamed:@"WindCell" owner:self options:nil];
            windCell = [windNIB objectAtIndex:0];
        }
        windCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [windCell expandReformat];
        }
        else
        {
            [windCell closeReformat];
        }
        if (_isMaunaKea && _dataDict[@"wind_speed"])
        {
            [windCell formatNumbersAndSetText:_dataDict[@"wind_speed"]:_dataDict[@"wind_speed_mph"]:_dataDict[@"wind_dir"]:_dataDict[@"ave_wind_dir"]:_dataDict[@"max_wind_speed"]:_dataDict[@"max_wind_speed_mph"]:_dataDict[@"max_wind_speed_time"]];
        }
        if (_dataDict[@"ave_wind_speed_ms"])
        {
           [windCell formatNumbersAndSetText:_dataDict[@"ave_wind_speed_ms"]:_dataDict[@"wind_speed_mph"]:_dataDict[@"wind_dir"]:_dataDict[@"ave_wind_dir"]:_dataDict[@"max_wind_speed_ms"]:_dataDict[@"max_wind_speed_mph"]:_dataDict[@"max_wind_speed_time"]];
        }
        return windCell;
    }
    // PRESSURE (ROW 6) (ROW 4 in MK)
    else if (indexPath.row == 6 || (_isMaunaKea && indexPath.row == 4))
    {
        PressureCell *pressCell = (PressureCell *)[tableView dequeueReusableCellWithIdentifier:@"pressureCell"];
        if (pressCell == nil)
        {
            NSArray *pressNIB = [[NSBundle mainBundle] loadNibNamed:@"PressureCell" owner:self options:nil];
            pressCell = [pressNIB objectAtIndex:0];
        }
        pressCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [pressCell expandReformat];
        }
        else
        {
            [pressCell closeReformat];
        }
        if (_isMaunaKea && _dataDict[@"pressure"])
        {
            [pressCell formatNumbersAndSetText:_dataDict[@"pressure"]];
        }
        else if (_dataDict[@"ave_pressure"])
        {
            [pressCell formatNumbersAndSetText:_dataDict[@"ave_pressure"]];
        }
        return pressCell;
    }
    // DEWPOINT (ROW 7) (ROW 5 in MK)
    else if (indexPath.row == 7 || (_isMaunaKea && indexPath.row == 5))
    {
        DewpointCell *dewCell = (DewpointCell *)[tableView dequeueReusableCellWithIdentifier:@"dewpointCell"];
        if (dewCell == nil)
        {
            NSArray *dewNIB = [[NSBundle mainBundle] loadNibNamed:@"DewpointCell" owner:self options:nil];
            dewCell = [dewNIB objectAtIndex:0];
        }
        dewCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [dewCell expandReformat];
        }
        else
        {
            [dewCell closeReformat];
        }
        if (_isMaunaKea && _dataDict[@"dewpoint"])
        {
            [dewCell formatNumbersAndSetText:_dataDict[@"dewpoint"]];
        }
        else if (_dataDict[@"ave_dewpoint"])
        {
            [dewCell formatNumbersAndSetText:_dataDict[@"ave_dewpoint"]];
        }
        return dewCell;
    }
    // SUN AND MOON (ROW 8) (Not in MK)
    else
    {
        SunMoonCell *sunMoonCell = (SunMoonCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingSunMoonCell"];
        if (sunMoonCell == nil)
        {
            NSArray *sunMoonNIB = [[NSBundle mainBundle] loadNibNamed:@"SunMoonCell" owner:self options:nil];
            sunMoonCell = [sunMoonNIB objectAtIndex:0];
        }
        sunMoonCell.clipsToBounds = YES;
        if (selectedIndex == indexPath.row)
        {
            [sunMoonCell expandReformat];
        }
        else
        {
            [sunMoonCell closeReformat];
        }
        if (_dataDict[@"sunrise"])
        {
            [sunMoonCell formatNumbersAndSetText:_dataDict[@"sunrise"]:_dataDict[@"sunset"]:_dataDict[@"moonrise"]:_dataDict[@"moonset"]:_dataDict[@"illum"]:_dataDict[@"segment"]];
        }
        return sunMoonCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isMaunaKea)
    {
        // If row is selected, expand it to its unique cell height.
        if ((selectedIndex == indexPath.row) && (selectedIndex == 0)) { return 90; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 1)) { return 85; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 2)) { return 55; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 3)) { return 255; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 4)) { return 55; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 5)) { return 55; }
        // All closed cells have default height of 55.
        return 55;
    }
    else
    {
        if ((selectedIndex == indexPath.row) && (selectedIndex == 0)) { return 90; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 1)) { return 160; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 2)) { return 55; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 3)) { return 85; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 4)) { return 124; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 5)) { return 314; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 6)) { return 55; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 7)) { return 55; }
        if ((selectedIndex == indexPath.row) && (selectedIndex == 8)) { return 240; }
        return 55;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isMaunaKea)
    {
        return 6;
    }
    return 9;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the user taps expanded row, shrink the cell and end.
    if (selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    // If the user taps another row while a cell is expanded, shrink the expanded cell.
    if (selectedIndex != -1)
    {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = (int) indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    // Expand the cell that has been tapped.
    selectedIndex = (int) indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
