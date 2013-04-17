//
//  GlobalData.m
//  DCL_demo
//
//  Created by Ernesto Hernandez on 11/21/11.
//  Copyright (c) 2011 UIEvolution. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

@synthesize mViewManager;
@synthesize mRootBeerParser; 
@synthesize mRootBeer; 
@synthesize mRootList; 

static GlobalData* _sharedData = nil;

+(GlobalData *)sharedData
{
	if(!_sharedData)
	{
		_sharedData = [[self alloc] init];
	}
	return _sharedData;
}


+(id)alloc
{
	return [super alloc];
}

-(void) setup
{
    mViewManager = [[ViewManager alloc] init];
    mRootBeerParser = [[RootBeerFeedParser alloc] init]; 
    mRootBeer = [[RootBeers alloc]init]; 
    mRootList = [[NSMutableArray alloc]init]; 
    
}
-(id) init
{
    [self setup];
	return self;
}

@end
