//
//  RootBeers.h
//  BaseApp
//
//  Created by Blaine Anderson on 9/29/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootBeers.h"

@interface RootBeers : NSObject{
    BOOL isFav;
}

@property(strong, nonatomic) RootBeers* rootBeer; 

@property(strong, nonatomic) NSString* name; 
@property(strong, nonatomic) NSString* notes; 
@property(strong, nonatomic) NSString* brewer; 
@property(strong, nonatomic) NSMutableArray* ingredients; 
@property(strong, nonatomic) NSString* description; 
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSString* details;
@property(strong, nonatomic) NSString* caneSugar; 
@property(strong, nonatomic) NSString* caffeine; 
@property(strong, nonatomic) NSString* location; 
@property(strong, nonatomic) NSNumber* overallRating;
@property BOOL isFav;
 
@property int rating;




@end
