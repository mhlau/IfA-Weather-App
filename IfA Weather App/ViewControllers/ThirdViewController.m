//
//  ThirdViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/30/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A UIViewController that uses a UITableView to display CPTGraphHostViews in
//  GraphCells. Downloads and formats dictionaries of data from .php files on koa.
//

#import "ThirdViewController.h"
#import "GraphCell.h"
#import "SWRevealViewController.h"

@interface ThirdViewController ()
{
    DataParser *_dataParser;
    NSMutableDictionary *_dataDict;
    NSMutableArray *_dataArray;
    NSArray *_data;
    NSMutableArray *_axisTicks;
    NSMutableArray *_axisLabels;
    BOOL _isTemp;
    BOOL _isPress;
    BOOL _isHumid;
    BOOL _isWindSpd;
    BOOL _isWindDir;
    BOOL _isVis;
    BOOL _isInsol;
    BOOL _is48Hours;
    BOOL _isMaunaKea;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThirdViewController

@synthesize temperatureHostView,
pressureHostView,
humidityHostView,
windSpeedHostView,
windDirectionHostView,
visibilityHostView,
insolationHostView,
dewpointHostView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up tableView as DataParser datasource and delegate.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Initialize DataParser and structures used to store data.
    _dataDict = [[NSMutableDictionary alloc] init];
    _dataParser = [[DataParser alloc] init];
    _dataParser.delegate = self;
    _dataArray = [[NSMutableArray alloc] init];
    if (_is48Hours)
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/weather/appbin/plots/HPlotData48.php"];
    }
    else
    {
        if (_isMaunaKea)
        {
            [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/weather/appbin/plots/MKPlotData24.php"];
        }
        else
        {
            [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/weather/appbin/plots/HPlotData24.php"];
        }
    }
    
    // Set up the sidebar.
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)itemsDownloaded:(NSMutableDictionary *)itemDict
{
    // Set data dictionary to the dictionary that was downloaded.
    // itemDict is a dictionary of dictionaries of weather data.
    [_dataDict removeAllObjects];
    _dataDict = itemDict;
    // Reload the tableView to display downloaded data.
    [self.tableView reloadData];
}

#pragma mark Segue Identifier setters
-(void)set48Hours: (BOOL)is48Hours
{
    _is48Hours = is48Hours;
}

-(void)setMaunaKea: (BOOL)isMaunaKea
{
    _isMaunaKea = isMaunaKea;
}

#pragma mark UITableView methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TEMPERATURE (ROW 0)
    if (indexPath.row == 0)
    {
        // Tell the rest of the methods that the temperature cell is being referenced.
        _isTemp = true;
        // Make new graph cell and load it from the .xib file.
        GraphCell *temperatureGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (temperatureGraphCell == nil)
        {
            NSArray *temperatureNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            temperatureGraphCell = [temperatureNIB objectAtIndex:0];
        }
        // Initialize the HostView frame.
        self.temperatureHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 320, 270)];
        // Initialize the cell data, plot, graph, and axes.
        [self initPlot :self.temperatureHostView :@"Temperature (\u00B0C)"];
        // Add the HostView to the table view.
        [tableView addSubview:self.temperatureHostView];
        // Tell the rest of the methods that the temperature cell is no longer being referenced.
        _isTemp = false;
        return temperatureGraphCell;
    }
    // PRESSURE (ROW 1)
    else if (indexPath.row == 1)
    {
        _isPress = true;
        GraphCell *pressureGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (pressureGraphCell == nil)
        {
            NSArray *pressureNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            pressureGraphCell = [pressureNIB objectAtIndex:0];
        }
        self.pressureHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 320, 320, 270)];
        [self initPlot :self.pressureHostView :@"Pressure (mbar)"];
        [tableView addSubview:self.pressureHostView];
        _isPress = false;
        return pressureGraphCell;
    }
    // HUMIDITY (ROW 2)
    else if (indexPath.row == 2)
    {
        _isHumid = true;
        GraphCell *humidityGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (humidityGraphCell == nil)
        {
            NSArray *humidityNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            humidityGraphCell = [humidityNIB objectAtIndex:0];
        }
        self.humidityHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 640, 320, 270)];
        [self initPlot :self.humidityHostView :@"Humidity (%)"];
        [tableView addSubview:self.humidityHostView];
        _isHumid = false;
        return humidityGraphCell;
    }
    // WIND SPEED (ROW 3)
    else if (indexPath.row == 3)
    {
        _isWindSpd = true;
        GraphCell *windSpeedCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (windSpeedCell == nil)
        {
            NSArray *windSpeedNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            windSpeedCell = [windSpeedNIB objectAtIndex:0];
        }
        self.windSpeedHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 960, 320, 270)];
        [self initPlot :self.windSpeedHostView :@"Wind Speed (m/s)"];
        [tableView addSubview:self.windSpeedHostView];
        _isWindSpd = false;
        return windSpeedCell;
    }
    // WIND DIRECTION (ROW 4)
    else if (indexPath.row == 4)
    {
        _isWindDir = true;
        GraphCell *windDirectionCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (windDirectionCell == nil)
        {
            NSArray *windDirectionNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            windDirectionCell = [windDirectionNIB objectAtIndex:0];
        }
        self.windDirectionHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1280, 320, 270)];
        [self initPlot :self.windDirectionHostView :@"Wind Direction"];
        [tableView addSubview:self.windDirectionHostView];
        _isWindDir = false;
        return windDirectionCell;
    }
    // VISIBILITY (ROW 5)
    else if (indexPath.row == 5 && !_isMaunaKea)
    {
        _isVis = true;
        GraphCell *visibilityGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (visibilityGraphCell == nil)
        {
            NSArray *visibilityNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            visibilityGraphCell = [visibilityNIB objectAtIndex:0];
        }
        self.visibilityHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1600, 320, 270)];
        [self initPlot :self.visibilityHostView :@"Visibility (km)"];
        [tableView addSubview:self.visibilityHostView];
        _isVis = false;
        return visibilityGraphCell;
    }
    // INSOLATION (ROW 6)
    else if (!_isMaunaKea)
    {
        _isInsol = true;
        GraphCell *insolationGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (insolationGraphCell == nil)
        {
            NSArray *insolationNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            insolationGraphCell = [insolationNIB objectAtIndex:0];
        }
        self.insolationHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1920, 320, 270)];
        [self initPlot :self.insolationHostView :@"Insolation (kW / m\u00B2)"];
        [tableView addSubview:self.insolationHostView];
        _isInsol = false;
        return insolationGraphCell;
    }
    else
    {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isMaunaKea)
    {
        return 5;
    }
    return 7;
}

#pragma mark chart behavior
-(void)initPlot:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Initialize the data plot for the corresponding hostview.
    [self configureData:hostView];
    [self configureGraph:hostView :graphTitle];
    [self configurePlots:hostView];
    [self configureAxes:hostView :graphTitle];
}

-(void)setAxisLabels :(int)index :(int)totalKeys :(NSDictionary *)dict :(NSNumber *)secondsNum :(NSMutableArray *)axisLabels :(NSMutableArray *) axisTicks
{
    // Add axis tick locations and labels to their respective arrays.
    // Space out tick locations evenly - divide total number of entries by 8.
    for (int i = 0; i < 8; i++)
    {
        if (index == (int) (totalKeys * i/8))
        {
            [_axisLabels addObject:dict[@"time"]];
            [_axisTicks addObject:secondsNum];
            break;
        }
    }
    // Add last tick at the end of the data set.
    if (index == totalKeys - 1)
    {
        [_axisLabels addObject:dict[@"time"]];
        [_axisTicks addObject:secondsNum];
    }
}

-(void)configureData:(CPTGraphHostingView *)hostView
{
    // Set field for dictionary according to the current graph HostView.
    NSString *field = [[NSString alloc] init];
    if (hostView == self.temperatureHostView)
    {
        field = @"temperature";
    }
    else if (hostView == self.pressureHostView)
    {
        field = @"pressure";
    }
    else if (hostView == self.humidityHostView)
    {
        field = @"humidity";
    }
    else if (hostView == self.windSpeedHostView)
    {
        field = @"wind_speed";
    }
    else if (hostView == self.windDirectionHostView)
    {
        field = @"wind_direction";
    }
    else if (hostView == self.visibilityHostView)
    {
        field = @"visibility";
    }
    else if (hostView == self.insolationHostView)
    {
        field = @"insolation";
    }
    // Get the data dictionary for the selected field.
    NSDictionary *dictAtField = _dataDict[field];
    NSMutableArray *newData = [NSMutableArray array];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    _axisLabels = [[NSMutableArray alloc] init];
    _axisTicks = [[NSMutableArray alloc] init];
    int totalKeys = (int) [dictAtField allKeys].count;
    // Iterate over every entry in the dictionary:
    for (int i = 0; i < totalKeys; i++)
    {
        // Format the seconds field from the dictionary, then add the (seconds, value) pair to the data array.
        NSString *key = [NSString stringWithFormat:@"%d", i];
        NSDictionary *dictAtIndex = [dictAtField objectForKey:key];
        int seconds = [dictAtIndex[@"seconds"] intValue];
        NSNumber *secondsNum = [NSNumber numberWithInt:seconds];
        NSString *valueString = (NSString *)dictAtIndex[@"value"];
        NSNumber *valueNum = [numFormatter numberFromString:valueString];
        [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): valueNum }];
        [self setAxisLabels :i :totalKeys :dictAtIndex :secondsNum :_axisLabels :_axisTicks];
    }
    _data = newData;
}

-(void)configureGraph:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Create the graph.
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    hostView.hostedGraph = graph;
    // Set graph title.
    graph.title = graphTitle;
    // Create and set text style.
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor blackColor];
    titleStyle.fontName = @"Helvetica Neue";
    titleStyle.fontSize = 17.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -10.0f);
    // Set padding for plot area.
    [graph.plotAreaFrame setPaddingLeft:30.0f];
    [graph.plotAreaFrame setPaddingBottom:30.0f];
    // Enable user interactions for plot space.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(2.0)];
}

-(void)configurePlots:(CPTGraphHostingView *)hostView
{
    // Get graph and plot space.
    CPTGraph *graph = hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    // Create the plot.
    CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];
    plot.dataSource = self;
    // Change the color of the trend line depending on the location.
    CPTColor *color = [CPTColor colorWithComponentRed:50.0/255.0f
                                                green:205.0/255.0f
                                                 blue:50.0/255.0f
                                                alpha:1.0f];
    if (_is48Hours)
    {
        color =[ CPTColor colorWithComponentRed:30/255.0f
                                          green:144/255.0f
                                           blue:255/255.0f
                                          alpha:1.0f];
    }
    else if (_isMaunaKea)
    {
        color =[ CPTColor colorWithComponentRed:244/255.0f
                                          green:164/255.0f
                                           blue:96/255.0f
                                          alpha:1.0f];
    }
    [graph addPlot:plot toPlotSpace:plotSpace];
    // Set up plot space.
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:plot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    // Set up the y-range of the graph, depending on which graph it is.
    if (_isHumid)
    {
        if (_isMaunaKea)
        {
            [yRange expandRangeByFactor:CPTDecimalFromCGFloat(3.0f)];
        }
        else
        {
           [yRange expandRangeByFactor:CPTDecimalFromCGFloat(5.5f)];
        }
    }
    else if (_isPress)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(15.0f)];
    }
    else if (_isWindSpd || _isWindDir)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(2.0f)];
    }
    else if (_isVis)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(13.0f)];
    }
    else if (_isInsol)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(2.8f)];
    }
    else
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(6.6f)];
    }
    plotSpace.yRange = yRange;
    // Create styles and symbols (data point markers).
    CPTMutableLineStyle *lineStyle = [plot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 1.5;
    lineStyle.lineColor = color;
    plot.dataLineStyle = lineStyle;
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = color;
    CPTPlotSymbol *symbol = [CPTPlotSymbol ellipsePlotSymbol];
    symbol.fill = [CPTFill fillWithColor:color];
    symbol.lineStyle = symbolLineStyle;
    symbol.size = CGSizeMake(2.0f, 2.0f);
    plot.plotSymbol = symbol;
    plot.interpolation = CPTScatterPlotInterpolationCurved;
}

-(void)configureAxes:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Create styles for axes.
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica Neue";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor darkGrayColor];
    axisTextStyle.fontName = @"Helvetica Neue";
    axisTextStyle.fontSize = 13.0f;
    CPTMutableTextStyle *axisTextStyle2 = [[CPTMutableTextStyle alloc] init];
    axisTextStyle2.color = [CPTColor darkGrayColor];
    axisTextStyle2.fontName = @"Helvetica Neue";
    axisTextStyle2.fontSize = 13.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 2.0f;
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // Get axis set.
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) hostView.hostedGraph.axisSet;
    // Configure x-axis.
    CPTXYAxis *x = axisSet.xAxis;
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle2;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    NSArray *customTickLocations = [NSArray arrayWithArray:_axisTicks];
    NSSet *tickLocations = [NSSet setWithArray:customTickLocations];
    x.majorTickLocations = tickLocations;
    // Set the axis labels using the array initialized and filled in configureData.
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[_axisLabels count]];
    for (NSNumber *tickLocation in customTickLocations)
    {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [_axisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI/4;
        [customLabels addObject:newLabel];
    }
    x.axisLabels =  [NSSet setWithArray:customLabels];
    // Configure y-axis.
    CPTXYAxis *y = axisSet.yAxis;
    y.title = graphTitle;
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -40.0f;
    y.axisLineStyle = axisLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 10.0f;
    y.minorTickLength = 5.0f;
    y.tickDirection = CPTSignPositive;
    // Set up increments for axes.
    NSInteger majorIncrement = 10;
    NSInteger minorIncrement = 5;
    CGFloat yMax = 750;
    // Change y-axis increments depending on min/max values and fluctuations for given field.
    if (_isTemp)
    {
        yMax = 25;
        majorIncrement = 10;
        minorIncrement = 2;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isPress)
    {
        if (_isMaunaKea)
        {
            yMax = 650;
            majorIncrement = 5;
            minorIncrement = 1;
            x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(610.0);
            y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        }
        else
        {
            yMax = 750;
            majorIncrement = 5;
            minorIncrement = 1;
            x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(700.0);
            y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        }
    }
    else if (_isHumid)
    {
        yMax = 100;
        majorIncrement = 20;
        minorIncrement = 10;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isWindSpd)
    {
        yMax = 50;
        majorIncrement = 5;
        minorIncrement = 1;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isWindDir)
    {
        yMax = 1000;
        majorIncrement = 100;
        minorIncrement = 50;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(30.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isVis)
    {
        yMax = 200;
        majorIncrement = 50;
        minorIncrement = 25;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isInsol)
    {
        yMax = 5;
        majorIncrement = 1.0;
        minorIncrement = 1.0;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.56);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    // Set up y-axis labels based on
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement)
    {
        if (_isPress && !(j > 700) && !_isMaunaKea)
        {
            continue;
        }
        else if (_isPress && !(j > 600) && !_isMaunaKea)
        {
            continue;
        }
        NSUInteger mod = j % majorIncrement;
        if (mod == 0)
        {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%li", (long)j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            if (label)
            {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        }
        else
        {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    y.axisLabels = yLabels;    
    y.majorTickLocations = yMajorLocations;
    y.minorTickLocations = yMinorLocations;
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return _data.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    return _data[index][@(fieldEnum)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // Clear resources when the view disappears.
    self.view = nil;
    self.temperatureHostView = nil;
    self.pressureHostView = nil;
    self.humidityHostView = nil;
    self.windSpeedHostView = nil;
    self.windDirectionHostView = nil;
    self.visibilityHostView = nil;
    self.insolationHostView = nil;
    self.dewpointHostView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
