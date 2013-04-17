//
//  RootBeerFeedParser.m
//  BaseApp
//
//  Created by Blaine Anderson on 9/28/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "RootBeerFeedParser.h"
#import "GlobalData.h"

@implementation RootBeerFeedParser

 
@synthesize rootBeerList; 
@synthesize mRootBeer; 
@synthesize sortedRootBeerList; 

-(id) init
{
    if((self = [super init]))
    {
        rootBeerList = [[NSMutableArray alloc]init]; 
        mRootBeer = [[RootBeers alloc]init]; 
        
    }
    return self;
}

-(NSMutableArray*)getRootBeers{
    

    
    
    NSURL *rootBeerURL = [NSURL URLWithString:@"http://blaineanderson.net/RootBeerApp/RootBeer/allrootbeers"];
    NSError* error; 
    NSData* rootBeerData = [NSData dataWithContentsOfURL:rootBeerURL];
    NSLog(@"Data Data: %@", rootBeerData); 
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:rootBeerData  options:kNilOptions error:&error]; 
    
   [rootBeerList addObjectsFromArray:[json objectForKey:@"rootbeers"]]; 
    NSMutableArray* tempArray = [NSMutableArray array ]; 
   // sortedRootBeerList = [self sortRootBeerByName:rootBeerList];
    for(NSDictionary* rootBeer in rootBeerList){
        RootBeers* mRoot = [[RootBeers alloc] init]; 
        mRoot.name = [rootBeer objectForKey:@"Name"]; 
        mRoot.brewer = [rootBeer objectForKey:@"Brewer"];
        mRoot.id = [rootBeer objectForKey:@"Id"];
        mRoot.description = [rootBeer objectForKey:@"Description"];
        mRoot.details = [rootBeer objectForKey:@"ProductDetails"];
        mRoot.caneSugar = [ rootBeer objectForKey:@"Sugar"];
        mRoot.caffeine = [ rootBeer objectForKey:@"Caffeine"];
        mRoot.location = [ rootBeer objectForKey:@"Region"];
        mRoot.overallRating = [ rootBeer objectForKey:@"avgRating"];
        if (nil) {
             mRoot.isFav = FALSE; 
                } else if(mRoot.isFav==TRUE){
                     mRoot.isFav = TRUE; 
                        }
       
        NSLog(@"Name: %@", mRoot.name);
        NSLog(@"Name: %@", mRoot.brewer);
        NSLog(@"Name: %@", mRoot.id);
        NSLog(@"Name: %@", mRoot.description);
        NSLog(@"Name: %@", mRoot.details);
        NSLog(@"Caffeine: %@", mRoot.caffeine);
        NSLog(@"Sugar: %@", mRoot.caneSugar);
        NSLog(@"avgRating: %@", mRoot.overallRating);
        [tempArray addObject:mRoot]; 
        
    }
    rootBeerList = tempArray;
    
    [GlobalData sharedData].mRootList = rootBeerList; 
    
    NSLog(@"Rootbeer List: %@", rootBeerList); 
    return rootBeerList;
}

-(RootBeers*) getRootBeerAtIndex:(NSUInteger *)index{
    mRootBeer = [rootBeerList objectAtIndex:*index]; 
    return mRootBeer;
}

-(NSMutableArray*) sortRootBeer:(id)sender{
    rootBeerList = [[GlobalData sharedData] mRootList ];
   
    NSSortDescriptor *sorter; 
    NSString *sortBy = [(UIButton *)sender currentTitle];
    sorter = [NSSortDescriptor sortDescriptorWithKey:sortBy ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDesc = [NSArray arrayWithObject:sorter];
    NSArray *tempArray = [NSArray arrayWithArray:[rootBeerList sortedArrayUsingDescriptors:sortDesc]];
    rootBeerList = [tempArray mutableCopy]; 
    NSLog(@"Sorted Rootbeer List: %@", rootBeerList); 
   
    return rootBeerList;
}
@end
