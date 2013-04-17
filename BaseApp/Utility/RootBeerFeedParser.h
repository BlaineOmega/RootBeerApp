//
//  RootBeerFeedParser.h
//  BaseApp
//
//  Created by Blaine Anderson on 9/28/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootBeers.h" 

@interface RootBeerFeedParser : NSObject

@property(strong, nonatomic) NSMutableArray* rootBeerList;
@property(strong, nonatomic) RootBeers* mRootBeer; 
@property(strong, nonatomic) NSMutableArray* sortedRootBeerList; 

-(id)init; 
-(NSMutableArray*) getRootBeers;
-(RootBeers*) getRootBeerAtIndex:(NSUInteger *) index;
-(NSMutableArray*) sortRootBeer:(id)sender;

@end
