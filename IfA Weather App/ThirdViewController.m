//
//  ThirdViewController.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/30/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import "ThirdViewController.h"
#import "GraphCell.h"
#import "SWRevealViewController.h"

@interface ThirdViewController ()
{
    DataParser *_dataParser;
    NSMutableDictionary *_dataDict;
    NSMutableArray *_dataArray;
    NSArray *_temperatureDataArray;
    NSArray *_pressureDataArray;
    NSArray *_humidityDataArray;
    NSArray *_windSpeedDataArray;
    NSArray *_windDirectionDataArray;
    NSArray *_visibilityDataArray;
    NSArray *_insolationDataArray;
    NSArray *_dewpointDataArray;
    NSString *_axisLabel0;
    NSString *_axisLabel1;
    NSString *_axisLabel2;
    NSString *_axisLabel3;
    NSString *_axisLabel4;
    NSString *_axisLabel5;
    NSString *_axisLabel6;
    NSString *_axisLabel7;
    NSString *_axisLabel8;
    NSNumber *_axisTick0;
    NSNumber *_axisTick1;
    NSNumber *_axisTick2;
    NSNumber *_axisTick3;
    NSNumber *_axisTick4;
    NSNumber *_axisTick5;
    NSNumber *_axisTick6;
    NSNumber *_axisTick7;
    NSNumber *_axisTick8;
    NSArray *_axisArray;
    BOOL _isTemp;
    BOOL _isPress;
    BOOL _isHumid;
    BOOL _isWindSpd;
    BOOL _isWindDir;
    BOOL _isVis;
    BOOL _isInsol;
    BOOL _is48Hours;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThirdViewController

@synthesize temperatureHostView, pressureHostView, humidityHostView, windSpeedHostView, windDirectionHostView, visibilityHostView, insolationHostView, dewpointHostView;

-(void)set48Hours: (BOOL)is48Hours
{
    _is48Hours = is48Hours;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
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
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HPlotData48.php"];
    }
    else
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HPlotData24.php"];    
    }
}

#pragma mark UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TEMPERATURE (ROW 0)
    if (indexPath.row == 0) {
        _isTemp = true;
        GraphCell *temperatureGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (temperatureGraphCell == nil)
        {
            NSArray *temperatureNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            temperatureGraphCell = [temperatureNIB objectAtIndex:0];
        }
        self.temperatureHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
        [self initPlot :self.temperatureHostView :@"Temperature"];
        [tableView addSubview:self.temperatureHostView];
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
        self.pressureHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 320, 320, 250)];
        [self initPlot :self.pressureHostView :@"Pressure"];
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
        self.humidityHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 640, 320, 250)];
        [self initPlot :self.humidityHostView :@"Humidity"];
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
        self.windSpeedHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 960, 320, 250)];
        [self initPlot :self.windSpeedHostView :@"Wind Speed"];
        [tableView addSubview:self.windSpeedHostView];
        _isWindSpd = false;
        return windSpeedCell;
    }
    // WIND DIRECTION (ROW 4)
    else if (indexPath.row == 4) {
        _isWindDir = true;
        GraphCell *windDirectionCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (windDirectionCell == nil)
        {
            NSArray *windDirectionNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            windDirectionCell = [windDirectionNIB objectAtIndex:0];
        }
        self.windDirectionHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1280, 320, 250)];
        [self initPlot :self.windDirectionHostView :@"Wind Direction"];
        [tableView addSubview:self.windDirectionHostView];
        _isWindDir = false;
        return windDirectionCell;
    }
    // VISIBILITY (ROW 5)
    else if (indexPath.row == 5)
    {
        _isVis = true;
        GraphCell *visibilityGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (visibilityGraphCell == nil)
        {
            NSArray *visibilityNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            visibilityGraphCell = [visibilityNIB objectAtIndex:0];
        }
        self.visibilityHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1600, 320, 250)];
        [self initPlot :self.visibilityHostView :@"Visibility"];
        [tableView addSubview:self.visibilityHostView];
        _isVis = false;
        return visibilityGraphCell;
    }
    // INSOLATION (ROW 6)
    else if (indexPath.row == 6)
    {
        _isInsol = true;
        GraphCell *insolationGraphCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (insolationGraphCell == nil)
        {
            NSArray *insolationNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            insolationGraphCell = [insolationNIB objectAtIndex:0];
        }
        self.insolationHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 1920, 320, 250)];
        [self initPlot :self.insolationHostView :@"Insolation"];
        [tableView addSubview:self.insolationHostView];
        _isInsol = false;
        return insolationGraphCell;
    }
    // DEWPOINT (ROW 7)
    else
    {
        GraphCell *dewpointCell = (GraphCell *)[tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
        if (dewpointCell == nil)
        {
            NSArray *dewpointNIB = [[NSBundle mainBundle] loadNibNamed:@"GraphCell" owner:self  options:nil];
            dewpointCell = [dewpointNIB objectAtIndex:0];
        }
        self.dewpointHostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 2240, 320, 250)];
        [self initPlot :self.dewpointHostView :@"Dewpoint"];
        [tableView addSubview:self.dewpointHostView];
        return dewpointCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}

-(void)itemsDownloaded:(NSMutableDictionary *)itemDict
{
    // Set data dictionary to the dictionary that was downloaded.
    // itemDict is a dictionary of dictionaries of weather data.
    [_dataDict removeAllObjects];
    _dataDict = itemDict;
    // Insert data from dictionary into array, sorted by date.
    for (int i = 0; i < _dataDict.count; i++) {
        id idString = [NSString stringWithFormat:@"%d", i];
        _dataArray[i] = [_dataDict objectForKey:idString];
    }
    // Reload the tableView to display downloaded data.
    [self.tableView reloadData];
}

#pragma mark - Chart behavior
-(void)initPlot:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Initialize the data plot for the corresponding hostview.
    [self configureData:hostView];
    [self configureGraph:hostView :graphTitle];
    [self configurePlots:hostView];
    [self configureAxes:hostView :graphTitle];
}

-(void)configureData:(CPTGraphHostingView *)hostView
{
    NSMutableArray *newData = [NSMutableArray array];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    for (int i = 0; i < _dataArray.count; i++)
    {
        // Take the dictionary at the ith index of the data array.
        // Get the Unix time relative to the first data point (first point -> Unix time = 0).
        NSDictionary *dict = _dataArray[i];
        int unixseconds = [dict[@"unixseconds"] intValue];
        NSNumber *unixsecondsNumber = [NSNumber numberWithInt:unixseconds];
        // If 48-hour data is to be plotted, expand the x-axis range by a factor of 2.
        int factor = 1;
        if (_is48Hours)
        {
            factor = 2;
        }
        if (unixseconds == 0)
        {
            _axisLabel0 = dict[@"time"];
            _axisTick0 = unixsecondsNumber;
        }
        if (unixseconds > 10000 * factor && unixseconds < 11000 * factor)
        {
            _axisLabel1 = dict[@"time"];
            _axisTick1 = unixsecondsNumber;
        }
        if (unixseconds > 21000 * factor && unixseconds < 22000 * factor)
        {
            _axisLabel2 = dict[@"time"];
            _axisTick2 = unixsecondsNumber;
        }
        if (unixseconds > 32100 * factor && unixseconds < 33100 * factor)
        {
            _axisLabel3 = dict[@"time"];
            _axisTick3 = unixsecondsNumber;
        }
        if (unixseconds > 43000 * factor && unixseconds < 44000 * factor)
        {
            _axisLabel4 = dict[@"time"];
            _axisTick4 = unixsecondsNumber;
        }
        if (unixseconds > 54000 * factor && unixseconds < 55000 * factor)
        {
            _axisLabel5 = dict[@"time"];
            _axisTick5 = unixsecondsNumber;
        }
        if (unixseconds > 64000 * factor && unixseconds < 65000 * factor)
        {
            _axisLabel6 = dict[@"time"];
            _axisTick6 = unixsecondsNumber;
        }
        if (unixseconds > 75000 * factor && unixseconds < 76000 * factor)
        {
            _axisLabel7 = dict[@"time"];
            _axisTick7 = unixsecondsNumber;
        }
        if (unixseconds > 85400 * factor && unixseconds < 86400 * factor)
        {
            _axisLabel8 = dict[@"time"];
            _axisTick8 = unixsecondsNumber;
        }
        _axisArray = [[NSArray alloc] initWithObjects:_axisLabel0, _axisLabel1, _axisLabel2, _axisLabel3, _axisLabel4, _axisLabel5, _axisLabel6, _axisLabel7, _axisLabel8, nil];
        // Create number formatter for crazy decimals in data values.
        
        // TEMPERATURE DATA
        if (hostView == self.temperatureHostView)
        {
            // Get and round the value associated with the key from the dictionary.
            NSString *y = (NSString *)_dataArray[i][@"temperature"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            // Add the (HOUR-MINUTE, value) tuple to newData, and associate with (x,y) axes.
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            // Store the tuples in the corresponding array.
            _temperatureDataArray = newData;
        }
        // PRESSURE DATA
        else if (hostView == self.pressureHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"pressure"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _pressureDataArray = newData;
        }
        // HUMIDITY DATA
        else if (hostView == self.humidityHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"humidity"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _humidityDataArray = newData;
        }
        // WIND SPEED DATA
        else if (hostView == self.windSpeedHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"wind_speed"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _windSpeedDataArray = newData;
        }
        // WIND DIRECTION DATA
        else if (hostView == self.windDirectionHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"wind_direction"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _windDirectionDataArray = newData;
        }
        // VISIBILITY DATA
        else if (hostView == self.visibilityHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"visibility"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _visibilityDataArray = newData;
        }
        // INSOLATION DATA
        else if (hostView == self.insolationHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"insolation"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _insolationDataArray = newData;
        }
        // DEWPOINT DATA
        else if (hostView == self.dewpointHostView)
        {
            NSString *y = (NSString *)_dataArray[i][@"dewpoint"];
            NSNumber *y1 = [numFormatter numberFromString:y];
            [newData addObject:@{@(CPTScatterPlotFieldX): unixsecondsNumber, @(CPTScatterPlotFieldY): y1 }];
            _dewpointDataArray = newData;
        }
    }
}

-(void)configureGraph:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Create the graph.
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
    hostView.hostedGraph = graph;
    // Set graph title.
    graph.title = graphTitle;
    // Create and set text style.
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica Neue";
    titleStyle.fontSize = 17.0f;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -10.0f);
    // Set padding for plot area.
    [graph.plotAreaFrame setPaddingLeft:3.0f];
    [graph.plotAreaFrame setPaddingBottom:3.0f];
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
    CPTColor *color = [CPTColor redColor];
    [graph addPlot:plot toPlotSpace:plotSpace];
    // Set up plot space.
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:plot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(4.3f)];
    plotSpace.yRange = yRange;
    // Create styles and symbols (data point markers).
    CPTMutableLineStyle *lineStyle = [plot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 0.7;
    lineStyle.lineColor = color;
    plot.dataLineStyle = lineStyle;
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = color;
    CPTPlotSymbol *symbol = [CPTPlotSymbol ellipsePlotSymbol];
    symbol.fill = [CPTFill fillWithColor:color];
    symbol.lineStyle = symbolLineStyle;
    symbol.size = CGSizeMake(1.5f, 1.5f);
    plot.plotSymbol = symbol;
}

-(void)configureAxes:(CPTGraphHostingView *)hostView :(NSString *)graphTitle
{
    // Create styles for axes.
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica Neue";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor whiteColor];
    axisTextStyle.fontName = @"Helvetica Neue";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableTextStyle *axisTextStyle2 = [[CPTMutableTextStyle alloc] init];
    axisTextStyle2.color = [CPTColor lightGrayColor];
    axisTextStyle2.fontName = @"Helvetica Neue";
    axisTextStyle2.fontSize = 11.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor whiteColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 1.0f;
    // Get axis set.
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) hostView.hostedGraph.axisSet;
    // Configure x-axis.
    CPTAxis *x = axisSet.xAxis;
    //x.title = @"Time";
    x.titleTextStyle = axisTitleStyle;
    x.titleOffset = 15.0f;
    x.axisLineStyle = axisLineStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = axisTextStyle2;
    x.majorTickLineStyle = axisLineStyle;
    x.majorTickLength = 4.0f;
    x.tickDirection = CPTSignNegative;
    NSArray *customTickLocations = [NSArray arrayWithObjects:_axisTick0, _axisTick1, _axisTick2, _axisTick3, _axisTick4, _axisTick5, _axisTick6, _axisTick7, _axisTick8, nil];
    BOOL labelsAreSet = true;
    for (int i = 0; i < 9; i++)
    {
        if (!_axisArray[i])
        {
            labelsAreSet = false;
        }
    }
    if (labelsAreSet)
    {
        NSUInteger labelLocation = 0;
        NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[_axisArray count]];
        for (NSNumber *tickLocation in customTickLocations)
        {
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [_axisArray objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
            newLabel.tickLocation = [tickLocation decimalValue];
            newLabel.offset = x.labelOffset + x.majorTickLength;
            newLabel.rotation = M_PI/4;
            [customLabels addObject:newLabel];
        }
        x.axisLabels =  [NSSet setWithArray:customLabels];
    }
    // Configure y-axis.
    CPTAxis *y = axisSet.yAxis;
    y.title = graphTitle;
    y.titleTextStyle = axisTitleStyle;
    y.titleOffset = -40.0f;
    y.axisLineStyle = axisLineStyle;
    y.majorGridLineStyle = gridLineStyle;
    y.labelingPolicy = CPTAxisLabelingPolicyAutomatic;
    y.labelTextStyle = axisTextStyle;
    y.labelOffset = 16.0f;
    y.majorTickLineStyle = axisLineStyle;
    y.majorTickLength = 10.0f;
    y.minorTickLength = 5.0f;
    y.tickDirection = CPTSignPositive;
    // Set up increments for axes.
    NSInteger majorIncrement = 10;
    NSInteger minorIncrement = 5;
    CGFloat yMax = 700.0f;
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%li", (long)j] textStyle:y.labelTextStyle];
            NSDecimal location = CPTDecimalFromInteger(j);
            label.tickLocation = location;
            label.offset = -y.majorTickLength - y.labelOffset;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        } else {
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
    return _dataArray.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // Called when initPlot is called - select corresponding data set for hostview.
    if (_isTemp)
    {
        return _temperatureDataArray[index][@(fieldEnum)];
    }
    else if (_isPress)
    {
        return _pressureDataArray[index][@(fieldEnum)];
    }
    else if (_isHumid)
    {
        return _humidityDataArray[index][@(fieldEnum)];
    }
    else if (_isWindSpd)
    {
        return _windSpeedDataArray[index][@(fieldEnum)];
    }
    else if (_isWindDir)
    {
        return _windDirectionDataArray[index][@(fieldEnum)];
    }
    else if (_isVis)
    {
        return _visibilityDataArray[index][@(fieldEnum)];
    }
    else if (_isInsol)
    {
        return _insolationDataArray[index][@(fieldEnum)];
    }
    return _dewpointDataArray[index][@(fieldEnum)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //unload view to demonstrate caching
    self.view = nil;
    self.temperatureHostView = nil;
    self.pressureHostView = nil;
    self.humidityHostView = nil;
    self.windSpeedHostView = nil;
    self.windDirectionHostView = nil;
    self.visibilityHostView = nil;
    self.insolationHostView = nil;
    self.dewpointHostView = nil;
    _dataDict = nil;
    _dataArray = nil;
    _temperatureDataArray = nil;
    _pressureDataArray = nil;
    _humidityDataArray = nil;
    _windSpeedDataArray = nil;
    _windDirectionDataArray = nil;
    _visibilityDataArray = nil;
    _insolationDataArray = nil;
    _dewpointDataArray = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
