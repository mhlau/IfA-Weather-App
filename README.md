# IfA Weather App

## About

The Institute for Astronomy Weather App provides a clean display of real-time data and images taken from observatories at the summits of Haleakala and Mauna Kea. 

## Running IfA Weather

Download SDWebImage from https://github.com/rs/SDWebImage, then add it to the IfA Weather App project. Several images downloaded in SecondViewController.m take a significant amount of time to load, so increase the download timeout in SDWebImageDownloader.m to the recommended value:

```objective-c
- (id)init {
    if ((self = [super init])) {
        _executionOrder = SDWebImageDownloaderFIFOExecutionOrder;
        _downloadQueue = [NSOperationQueue new];
        _downloadQueue.maxConcurrentOperationCount = 2;
        _URLCallbacks = [NSMutableDictionary new];
        _HTTPHeaders = [NSMutableDictionary dictionaryWithObject:@"image/webp,image/*;q=0.8" forKey:@"Accept"];
        _barrierQueue = dispatch_queue_create("com.hackemist.SDWebImageDownloaderBarrierQueue", DISPATCH_QUEUE_CONCURRENT);
        // mhlau changed this from 15.0 to 500.0.
        _downloadTimeout = 500.0;
    }
    return self;
}
```

## External Libraries and Packages

IfA Weather uses the following libraries and packages:
- CorePlot (https://github.com/core-plot/core-plot) as its graphing framework,
- SDWebImage and UIActivityIndicator-for-SDWebImage (https://github.com/JJSaccolo/UIActivityIndicator-for-SDWebImage) for asynchronous image downloads, 
- SWRevealViewController (https://github.com/John-Lluch/SWRevealViewController) and modified code from AppCoda (http://www.appcoda.com/ios-programming-sidebar-navigation-menu/) for its side-drawer navigation.

## App Screenshots

![](https://github.com/mhlau/IfA-Weather-App/blob/v9/example_images/HaleakalaWeather.png) ![](https://github.com/mhlau/IfA-Weather-App/blob/v9/example_images/MaunaKeaWeather.png) 
![](https://github.com/mhlau/IfA-Weather-App/blob/v9/example_images/Haleakala24HourTrends.png) ![](https://github.com/mhlau/IfA-Weather-App/blob/v9/example_images/VisibleWeatherImages.png)
![](https://github.com/mhlau/IfA-Weather-App/blob/v9/example_images/24HourAnimations.gif)