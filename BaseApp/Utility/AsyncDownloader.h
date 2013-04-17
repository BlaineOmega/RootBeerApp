//
//  AsyncDownloader.h
//  DCL_demo
//
//  Created by UIEvolution UIE10226 on 1/4/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsyncDownloader;

@protocol AsyncDownloaderDelegate

@optional

-(void) didRecieveData:(AsyncDownloader*)downloader;
-(void) failedToRecieveData:(AsyncDownloader*)downloader;

@end

@interface AsyncDownloader : NSObject

@property (strong, nonatomic) NSURLConnection* mConnection;
@property (strong, nonatomic) NSMutableData* mData;
@property (strong, nonatomic) id mDelegate;

-(id) initWithURL:(NSString*)URL delegate:(id)delegate;

@end
