//
//  ViewManager.h
//  DCL_demo
//
//  Created by UIEvolution UIE10226 on 12/28/11.
//  Copyright (c) 2011 UIEvolution, Inc. All rights reserved.
//

//***** NEEDS QuartsCore framework *****//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SplashScreen.h"
#import "Home.h"
#import "RootBeerTableViewController.h"
#import "DetailViewController.h"
#import "RootBeerTVCViewController.h"

// toggle console debug data
#define VIEW_DEBUG                  NO

// YES to print view stack every time it changes
#define PRINT_VIEW_STACK            NO

// View Defines:
//              -Strings must match nib/xib name

#define SPLASH_SCREEN   @"SplashScreen"
#define HOME            @"Home"
#define ROOTBEERS       @"RootBeerTableViewController"
#define DETAILVIEW      @"DetailViewController"
#define RTVC            @"RootBeerTVCViewController"

// Transition Types

#define DEFAULT                     @""
#define FADE                        @"Fade"
 
///// View /////

@interface View : NSObject 

@property (strong, nonatomic) UIViewController* mViewController;
@property (strong, nonatomic) NSString* mID;
@property BOOL mCache;

-(id) initViewWithID:(NSString*)ID;

@end

///// View Manager /////

/////***** Notes on Caching *****/////
///// - Only one view of any type may be cached at any time

@interface ViewManager : NSObject

@property (strong, nonatomic) NSMutableArray* mViewStack;
@property (strong, nonatomic) NSMutableArray* mViewCache;

@property (strong, nonatomic) UINavigationController* mNavController;

@property (strong, nonatomic) NSString* mCustomTransition;
@property int mTransitionDuration;

-(id) init;
// push new view
-(void) pushView:(NSString*)ID animated:(BOOL)anim;
// push new view and set it to be cached
-(void) pushViewCached:(NSString*)ID animated:(BOOL)anim;
// replace current view
-(void) replaceView:(NSString*)ID animated:(BOOL)anim;
// replace current view and set new view to be cached
-(void) replaceViewCached:(NSString*)ID animated:(BOOL)anim;
// pop view
-(void) popView:(BOOL)anim;
// pop to closest instance of view type
-(void) popTo:(NSString*)ID animated:(BOOL)anim;
// pop to index in the stack
-(void) popToIndex:(int)index animated:(BOOL)anim;
// pop to certain view
-(void) popToView:(View*)view animated:(BOOL)anim;
-(void) setTransition:(NSString*)type;
// Cache
-(void) clearCachedViews;
-(void) removeViewFromCache:(NSString*)ID;
// Debug
-(void) printViewStack;
-(void) printViewCache;
-(id) getCurrentViewController;
-(View*) getCurrentView;

@end
