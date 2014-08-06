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
        // Micah Lau changed this from 15.0 to 500.0.
        _downloadTimeout = 500.0;
    }
    return self;
}
```