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
    NSUInteger _missing;
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
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HPlotData48CSV.php"];
    }
    else
    {
        [_dataParser downloadItems:@"http://koa.ifa.hawaii.edu/mhlau/HPlotData24CSV.php"];
    }
    // Set up the sidebar.
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    _missing = 0;
}

-(void)itemsDownloaded:(NSMutableDictionary *)itemDict
{
    // Set data dictionary to the dictionary that was downloaded.
    // itemDict is a dictionary of dictionaries of weather data.
    [_dataDict removeAllObjects];
    _dataDict = itemDict;
    // Insert data from dictionary into array, sorted by date.
    for (int i = 0; i < _dataDict.count; i++)
    {
        id idString = [NSString stringWithFormat:@"%d", i];
        _dataArray[i] = [_dataDict objectForKey:idString];
    }
    // Reload the tableView to display downloaded data.
    [self.tableView reloadData];
}

-(void)set48Hours: (BOOL)is48Hours
{
    _is48Hours = is48Hours;
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
    else if (indexPath.row == 5)
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
    else
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

-(void)setAxisLabels :(int)index :(NSDictionary *)dict :(NSNumber *)secondsNum
{
    int div8 = (int)_dataArray.count / 8;
    if (index == 0)
    {
        _axisLabel0 = dict[@"time"];
        _axisTick0 = secondsNum;
    }
    else if (index == div8)
    {
        _axisLabel1 = dict[@"time"];
        _axisTick1 = secondsNum;
    }
    else if (index == div8 * 2)
    {
        _axisLabel2 = dict[@"time"];
        _axisTick2 = secondsNum;
    }
    else if (index == div8 * 3)
    {
        _axisLabel3 = dict[@"time"];
        _axisTick3 = secondsNum;
    }
    else if (index == div8 * 4)
    {
        _axisLabel4 = dict[@"time"];
        _axisTick4 = secondsNum;
    }
    else if (index == div8 * 5)
    {
        _axisLabel5 = dict[@"time"];
        _axisTick5 = secondsNum;
    }
    else if (index == div8 * 6)
    {
        _axisLabel6 = dict[@"time"];
        _axisTick6 = secondsNum;
    }
    else if (index == div8 * 7)
    {
        _axisLabel7 = dict[@"time"];
        _axisTick7 = secondsNum;
    }
    else if (index == _dataArray.count - 1)
    {
        _axisLabel8 = dict[@"time"];
        _axisTick8 = secondsNum;
    }
    _axisArray = [[NSArray alloc] initWithObjects:_axisLabel0, _axisLabel1, _axisLabel2, _axisLabel3, _axisLabel4, _axisLabel5, _axisLabel6, _axisLabel7, _axisLabel8, nil];
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
        int seconds = [dict[@"seconds"] intValue];
        NSNumber *secondsNum = [NSNumber numberWithInt:seconds];
        // If 48-hour data is to be plotted, expand the x-axis range by a factor of 2.
        [self setAxisLabels:i :dict :secondsNum];
        // TEMPERATURE DATA
        if (hostView == self.temperatureHostView)
        {
            if (_dataArray[i][@"temperature"])
            {
                // Get and round the value associated with the key from the dictionary.
                NSString *y = (NSString *)_dataArray[i][@"temperature"];
                NSNumber *y1 = [numFormatter numberFromString:y];
                // Add the (HOUR-MINUTE, value) tuple to newData, and associate with (x,y) axes.
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                // Store the tuples in the corresponding array.
                _temperatureDataArray = newData;
            }
        }
        // PRESSURE DATA
        else if (hostView == self.pressureHostView)
        {
            if (_dataArray[i][@"pressure"])
            {
                NSString *y = (NSString *)_dataArray[i][@"pressure"];
                NSNumber *y1 = [numFormatter numberFromString:y];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _pressureDataArray = newData;
            }
        }
        // HUMIDITY DATA
        else if (hostView == self.humidityHostView)
        {
            if (_dataArray[i][@"humidity"])
            {
                NSString *y = (NSString *)_dataArray[i][@"humidity"];
                NSNumber *y1 = [numFormatter numberFromString:y];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _humidityDataArray = newData;
            }
        }
        // WIND SPEED DATA
        else if (hostView == self.windSpeedHostView)
        {
            if (_dataArray[i][@"wind_speed"])
            {
                NSString *y = (NSString *)_dataArray[i][@"wind_speed"];
                NSNumber *y1 = [numFormatter numberFromString:y];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _windSpeedDataArray = newData;
            }
        }
        // WIND DIRECTION DATA
        else if (hostView == self.windDirectionHostView)
        {
            if (_dataArray[i][@"wind_direction"])
            {
                NSString *y = (NSString *)_dataArray[i][@"wind_direction"];
                NSNumber *y1 = [numFormatter numberFromString:y];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _windDirectionDataArray = newData;
            }
        }
        // VISIBILITY DATA
        else if (hostView == self.visibilityHostView)
        {
            if (_dataArray[i][@"visibility"])
            {
                // No need to convert visibility from string to number -- already a NSNum.
                NSNumber *y1 = _dataArray[i][@"visibility"];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _visibilityDataArray = newData;
            }
            else
            {
                _missing++;
            }
        }
        // INSOLATION DATA
        else if (hostView == self.insolationHostView)
        {
            if (_dataArray[i][@"insolation"])
            {
                // No need to convert insolation from string to number -- already a NSNum.
                NSNumber *y1 = _dataArray[i][@"insolation_kWm2"];
                [newData addObject:@{@(CPTScatterPlotFieldX): secondsNum, @(CPTScatterPlotFieldY): y1 }];
                _insolationDataArray = newData;
            }
        }
    }
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
    CPTColor *color = [CPTColor colorWithComponentRed:50.0/255.0f green:205.0/255.0f blue:50.0/255.0f alpha:1.0f];
    if (_is48Hours)
    {
        color =[ CPTColor colorWithComponentRed:30/255.0f green:144/255.0f blue:255/255.0f alpha:1.0f];
    }
    [graph addPlot:plot toPlotSpace:plotSpace];
    // Set up plot space.
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:plot, nil]];
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.1f)];
    plotSpace.xRange = xRange;
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    if (_isVis)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(13.0f)];
    }
    else if (_isHumid)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(8.5f)];
    }
    else if (_isInsol)
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(2.8f)];
    }
    else
    {
        [yRange expandRangeByFactor:CPTDecimalFromCGFloat(4.3f)];
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
    NSArray *customTickLocations = [NSArray arrayWithObjects:_axisTick0, _axisTick1, _axisTick2, _axisTick3, _axisTick4, _axisTick5, _axisTick6, _axisTick7, _axisTick8, nil];
    NSSet *tickLocations = [NSSet setWithArray:customTickLocations];
    x.majorTickLocations = tickLocations;
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
    if (_isTemp)
    {
        yMax = 25;
        majorIncrement = 10;
        minorIncrement = 5;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(3.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isPress)
    {
        majorIncrement = 3;
        minorIncrement = 1;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(707.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
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
        majorIncrement = 10;
        minorIncrement = 5;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isWindDir)
    {
        yMax = 1000;
        majorIncrement = 200;
        minorIncrement = 50;
        x.orthogonalCoordinateDecimal = CPTDecimalFromDouble(40.0);
        y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    }
    else if (_isVis)
    {
        yMax = 100;
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
    NSMutableSet *yLabels = [NSMutableSet set];
    NSMutableSet *yMajorLocations = [NSMutableSet set];
    NSMutableSet *yMinorLocations = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement)
    {
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
    return _dataArray.count - _missing;
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
}

#pragma mark - Rotation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
