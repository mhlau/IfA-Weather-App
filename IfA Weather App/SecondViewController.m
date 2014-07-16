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
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

@synthesize imageURLs;

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _locations = [[NSArray alloc] initWithObjects:@"Haleakala", @"PS1 All-Sky", @"CFHT North View", @"CFHT South View", @"CFHT Northeast View", @"CFHT Southeast View", nil];
    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
    _index = 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#define IMAGE_VIEW_TAG 99
    NSString *cellIdentifier = @"expandingImageCell";
    ImageCell *imageCell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (imageCell == nil)
    {
        NSArray *imageCellNIB = [[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:self options:nil];
        imageCell = [imageCellNIB objectAtIndex:0];
        
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 57.0, 325.0f, 240.0f)];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		imageView.tag = IMAGE_VIEW_TAG;
		[imageCell addSubview:imageView];
    }
    AsyncImageView *imageView = (AsyncImageView *)[imageCell viewWithTag:IMAGE_VIEW_TAG];
    self.imageURLs = [imageCell getImageURLs];
    imageView.imageURL = [self.imageURLs objectAtIndex:indexPath.row];
    imageCell.locationLabel.text = _locations[indexPath.row];
    imageCell.clipsToBounds = YES;
    return imageCell;
}

-(void)reloadData
{
    // Clear cache so new image loads.
    [AsyncImageLoader sharedLoader].cache = nil;
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Unload view to demonstrate caching.
    self.view = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
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
