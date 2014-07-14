//
//  DataParser.h
//  IfA Weather App
//
//  Created by Micah Lau on 6/25/14.
//  Copyright (c) 2014 Institute for Astronomy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataParserProtocol <NSObject>

-(void)itemsDownloaded:(NSDictionary *)itemDict;

@end

@interface DataParser : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<DataParserProtocol> delegate;

-(void)downloadItems:(NSString *)url;

@end
