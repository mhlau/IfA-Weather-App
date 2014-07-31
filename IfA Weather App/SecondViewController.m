//
//  SecondViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/26/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "SecondViewController.h"
#import "ImageCell.h"
#import "AsyncImageView.h"
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SecondViewController ()
{
    NSArray *_locations;
    int *_index;
    BOOL _isMaunaKea;
    BOOL _isInfrared;
    BOOL _isWaterVapor;
    BOOL _isVisible;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

@synthesize imageURLs;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up tableView as DataParser datasource and delegate.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Initialize locations array depending on whether this is Haleakala or MK cell.
    if (_isMaunaKea)
    {
        _locations = [[NSArray alloc] initWithObjects:@"CFHT North", @"Gemini Telescope South", @"CFHT NNW", @"CFHT NNE", nil];
    }
    else if (_isInfrared)
    {
        _locations = [[NSArray alloc] initWithObjects:@"Big Island", @"Hawaii", @"Hawaii (Wide View)", @"Hawaii to Mainland", @"Pacific Northeast", @"Pacific Ocean", nil];
        self.navigationItem.title = @"Infrared Satellite Images";
    }
    else if (_isWaterVapor)
    {
        _locations = [[NSArray alloc] initWithObjects:@"Big Island", @"Hawaii", @"Hawaii (Wide View)", @"Hawaii to Mainland", @"Pacific Northeast", @"Pacific Ocean", nil];
        self.navigationItem.title = @"Water Vapor Images";
    }
    else if (_isVisible)
    {
        _locations = [[NSArray alloc] initWithObjects:@"Big Island", @"Hawaii", @"Hawaii (Wide View)", @"Hawaii to Mainland", nil];
        self.navigationItem.title = @"Visible Weather Images";
    }
    else
    {
        _locations = [[NSArray alloc] initWithObjects:@"Haleakala", @"PS1 All-Sky", nil];
    }
    // Set up the sidebar.
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"view disappeared");
    self.view = nil;
    _locations = nil;
    // Clear the AsyncImageLoader cache so that new images load when view is selected again.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expandingImageCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"expandingImageCell"];
    }
    
    // Here we use the new provided setImageWithURL: method to load the web image
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://ps1puka.ps1.ifa.hawaii.edu/cgi-bin/colorAllSkyCam?image=current"] placeholderImage:nil];
    
    cell.textLabel.text = @"My Text";
    return cell;
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
