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

@interface SecondViewController ()
{
    NSArray *_locations;
    int *_index;
    ImageCell *_cell;
}

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView2;

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
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    _locations = [[NSArray alloc] initWithObjects:@"Haleakala", @"PS1 All-Sky", @"CFHT North View", @"CFHT South View", @"CFHT Northeast View", @"CFHT Southeast View", nil];
    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
    _cell = nil;
    _index = 0;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //unload view to demonstrate caching
    self.view = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locations.count;
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
    else
    {
        //cancel loading previous image for cell
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageCell.thumbnail];
    }
    AsyncImageView *imageView = (AsyncImageView *)[imageCell viewWithTag:IMAGE_VIEW_TAG];
    //imageCell.thumbnail.image = [UIImage imageNamed:@"Placeholder.png"];
    self.imageURLs = [imageCell getImageURLs];
    //imageCell.thumbnail.imageURL = self.imageURLs[(NSUInteger)indexPath.row];
    imageView.imageURL = [self.imageURLs objectAtIndex:indexPath.row];
    //imageCell.thumbnail.clipsToBounds = YES;
    imageCell.locationLabel.text = _locations[indexPath.row];
    imageCell.clipsToBounds = YES;
    [self setCell:imageCell];
    return imageCell;
}

-(void)setCell :(ImageCell *)cell
{
    _cell = cell;
}

-(void)reloadData
{
    // Clear cache so new image loads.
    [AsyncImageLoader sharedLoader].cache = nil;
    for (int i = 0; i < self.imageURLs.count; i++)
    {
        _cell.thumbnail.imageURL = self.imageURLs[(NSUInteger) i];
    }
    
    [self.tableView2 reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}

@end
