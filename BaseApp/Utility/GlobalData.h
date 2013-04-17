//
//  GlobalData.h
//  DCL_demo
//
//  Created by Ernesto Hernandez on 11/21/11.
//  Copyright (c) 2011 UIEvolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewManager.h"
#import "RootBeerFeedParser.h"

#define ANIMATION_DURATION .25f

#define SLIDE_IN_TIME   .1f
#define WAIT_TIME       .5f

@interface GlobalData : NSObject

@property (strong, nonatomic) ViewManager* mViewManager;
@property(nonatomic, strong) RootBeerFeedParser* mRootBeerParser; 
@property(nonatomic, strong) RootBeers*  mRootBeer; 
@property(strong, nonatomic) NSMutableArray* mRootList; 

+(GlobalData*)sharedData;
-(void) setup;

@end
