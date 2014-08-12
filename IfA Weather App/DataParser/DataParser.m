//
//  DataParser.m
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//
//  A class that downloads JSON-formatted data from a URL and returns a dictionary containing the contents of the file.
//  Used in ViewController and ThirdViewController.
//

#import "DataParser.h"

@interface DataParser()
{
    NSMutableData *_downloadedData;
}
@end

@implementation DataParser

-(void)downloadItems:(NSString *)url
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:url];
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Parse the JSON that came in
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
        // Ready to notify delegate that data is ready and pass back items
        if (self.delegate)
        {
            [self.delegate itemsDownloaded:jsonDict];
        }
}

@end
