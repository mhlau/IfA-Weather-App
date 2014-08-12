//
//  SecondViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A UIViewController that downloads and uses a UITableView of ImageCells
//  to display images from various .php files hosted by kopiko.ifa.hawaii.edu.
//

#import "SecondViewController.h"
#import "ImageCell.h"
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@interface SecondViewController ()
{
    NSArray *_locations;
    NSArray *_URLs;
    int *_index;
    BOOL _isMaunaKea;
    BOOL _isInfrared;
    BOOL _isWaterVapor;
    BOOL _isVisible;
    BOOL _isAnimation;
    BOOL _isForecast;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up tableView as DataParser datasource and delegate.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Initialize location and URL arrays according to view type (via segue).
    // Mauna Kea Images view:
    if (_isMaunaKea)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"CFHT North",
                      @"Gemini Telescope South",
                      @"CFHT NNW",
                      @"CFHT NNE",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://cfht.hawaii.edu/webcams/cfhtdome/cfhtdome.jpg",
                 @"http://cfht.hawaii.edu/webcams/gemdome/gemdome.jpg",
                 @"http://cfht.hawaii.edu/webcams/c4/c4.jpg",
                 @"http://cfht.hawaii.edu/webcams/c3/c3.jpg",
                 nil];
    }
    // Infrared Images view:
    else if (_isInfrared)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Big Island",
                      @"Hawaii",
                      @"Hawaii (Wide View)",
                      @"Hawaii to Mainland",
                      @"Pacific Northeast",
                      @"Pacific Ocean",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRBigIsland.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRHawaii.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRHawaiiWide.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRHItoMain.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRPacificNE.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatIRPacificO.php",
                 nil];
        self.navigationItem.title = @"Infrared Satellite Images";
    }
    // Water Vapor images view:
    else if (_isWaterVapor)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Big Island",
                      @"Hawaii",
                      @"Hawaii (Wide View)",
                      @"Hawaii to Mainland",
                      @"Pacific Northeast",
                      @"Pacific Ocean",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVBigIsland.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVHawaii.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVHawaiiWide.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVHItoMain.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVPacificNE.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatWVPacificO.php",
                 nil];
        self.navigationItem.title = @"Water Vapor Images";
    }
    // Visible Weather images view:
    else if (_isVisible)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Big Island",
                      @"Hawaii",
                      @"Hawaii (Wide View)",
                      @"Hawaii to Mainland",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatVisBigIsland.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatVisHawaii.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatVisHawaiiWide.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKSatImages/MKSatVisHItoMain.php",
                 nil];
        self.navigationItem.title = @"Visible Weather Images";
    }
    // Animated images view:
    else if (_isAnimation)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Hawaii Infrared",
                      @"Hawaii to Mainland IR",
                      @"Hawaii Water Vapor",
                      @"Hawaii to Mainland WV",
                      @"Hawaii Visible Weather",
                      @"Hawaii to Mainland Vis",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKIRHawaiiGIF.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKIRHItoMainGIF.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKWVHawaiiGIF.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKWVHItoMainGIF.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKVisHawaiiGIF.php",
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKGifs/MKVisHItoMainGIF.php",
                 nil];
        self.navigationItem.title = @"24-Hour Animations";
    }
    else if (_isForecast)
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Six-Day Forecast",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://kopiko.ifa.hawaii.edu/weather/appbin/MKCurr/MKForecast.php",
                 nil];
        self.navigationItem.title = @"Mauna Kea Forecast";
    }
    // Haleakala Images view:
    else
    {
        _locations = [[NSArray alloc] initWithObjects:
                      @"Haleakala",
                      @"PS1 All-Sky",
                      nil];
        _URLs = [[NSArray alloc] initWithObjects:
                 @"http://132.160.98.225/axis-cgi/jpg/image.cgi",
                 @"http://ps1puka.ps1.ifa.hawaii.edu/cgi-bin/colorAllSkyCam?image=current",
                 nil];
    }
    
    // Set up the sidebar.
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

#pragma mark Segue Interaction Setters
-(void)setMaunaKea: (BOOL)isMaunaKea
{
    _isMaunaKea = isMaunaKea;
}

-(void)setInfrared: (BOOL)isInfrared
{
    _isInfrared = isInfrared;
}

-(void)setWaterVapor: (BOOL)isWaterVapor
{
    _isWaterVapor = isWaterVapor;
}

-(void)setVisible: (BOOL)isVisible
{
    _isVisible = isVisible;
}

-(void)setAnimation: (BOOL)isAnimation
{
    _isAnimation = isAnimation;
}

-(void)setForecast: (BOOL)isForecast
{
    _isForecast = isForecast;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
    // Clear the image cache so that images update upon new view appearance.
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *imageCell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:@"expandingImageCell"];
    if (imageCell == nil)
    {
        // Initialize ImageCell from .xib file.
        NSArray *imageCellNIB = [[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:self options:nil];
        imageCell = [imageCellNIB objectAtIndex:0];
    }
    // Use the new provided setImageWithURL: method to load the web image.
    [imageCell.imageView setImageWithURL:[NSURL URLWithString:_URLs[indexPath.row]]
                        placeholderImage:[UIImage imageNamed:@"Placeholder.png"]
                                 options:SDWebImageContinueInBackground
             usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    // Disable selection on imageCells.
    imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Set location labels for each cell.
    imageCell.locationLabel.text = _locations[indexPath.row];
    return imageCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 337;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locations.count;
}

@end
