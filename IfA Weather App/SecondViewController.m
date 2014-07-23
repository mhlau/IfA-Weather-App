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

@interface SecondViewController ()
{
    NSArray *_locations;
    int *_index;
    BOOL _isMaunaKea;
    BOOL _isSatellite;
    BOOL _isWaterVapor;
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
    else if (_isSatellite)
    {
        _locations = [[NSArray alloc] initWithObjects:@"Big Island", @"Hawaii", @"Hawaii (Wide View)", @"Hawaii to Mainland", @"Pacific Northeast", @"Pacific Ocean", nil];
    }
    else if (_isWaterVapor)
    {
        _locations = [[NSArray alloc] initWithObjects:@"Big Island", @"Hawaii", @"Hawaii (Wide View)", @"Hawaii to Mainland", @"Pacific Northeast", @"Pacific Ocean", nil];
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

-(void)setSatellite: (BOOL)isSatellite
{
    _isSatellite = isSatellite;
}

-(void)setWaterVapor: (BOOL)isWaterVapor
{
    _isWaterVapor = isWaterVapor;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.view = nil;
    _locations = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Tag used in animating image loading (spinning progress loader).
    #define IMAGE_VIEW_TAG 99
    // Initialize ImageCell.
    NSString *cellIdentifier = @"expandingImageCell";
    ImageCell *imageCell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (imageCell == nil)
    {
        // Initialize ImageCell from .xib file.
        NSArray *imageCellNIB = [[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:self options:nil];
        imageCell = [imageCellNIB objectAtIndex:0];
        // Initialize AsyncImageView, which holds and downloads the image.
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 57, 320.0f, 280.0f)];
		imageView.contentMode = UIViewContentModeRedraw;
		imageView.clipsToBounds = YES;
		imageView.tag = IMAGE_VIEW_TAG;
		[imageCell addSubview:imageView];
    }
    // If this is the MK Images view, have the ImageCell get the appropriate URLs. 
    if (_isMaunaKea)
    {
        [imageCell setMaunaKea:true];
        [imageCell awakeFromNib];
    }
    else if (_isSatellite)
    {
        [imageCell setSatellite:true];
        [imageCell awakeFromNib];
    }
    else if (_isWaterVapor)
    {
        [imageCell setWaterVapor:true];
        [imageCell awakeFromNib];
    }
    // Load image from URL in property list (in ImageCell group).
    AsyncImageView *imageView = (AsyncImageView *)[imageCell viewWithTag:IMAGE_VIEW_TAG];
    self.imageURLs = [imageCell getImageURLs];
    imageView.imageURL = [self.imageURLs objectAtIndex:indexPath.row];
    imageCell.locationLabel.text = _locations[indexPath.row];
    imageCell.clipsToBounds = YES;
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
