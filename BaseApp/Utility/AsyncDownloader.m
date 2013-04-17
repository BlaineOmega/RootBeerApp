//
//  AsyncDownloader.m
//  DCL_demo
//
//  Created by UIEvolution UIE10226 on 1/4/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "AsyncDownloader.h"

@implementation AsyncDownloader

@synthesize mData;
@synthesize mConnection;
@synthesize mDelegate;

-(id) initWithURL:(NSString*)URL delegate:(id)delegate
{
    if((self = [super init]))
    {
        mDelegate = delegate;
        mData = nil;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
        
        mConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    }
    return self;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    [mDelegate failedToRecieveData:self];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{   
    if (self.mData == nil)
    {
        self.mData = [[NSMutableData alloc] init];
    }
    [self.mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(mDelegate != nil)
    {
        [mDelegate didRecieveData:self];
    }
}

-(void) dealloc
{
    mConnection = nil;
    mData = nil;
    mDelegate = nil;
}

@end
