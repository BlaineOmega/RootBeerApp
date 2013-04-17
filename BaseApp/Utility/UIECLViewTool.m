//
//  ViewTool.m
//
//  Created by UIEvolution UIE10226 on 12/28/11.
//  Copyright (c) 2011 UIEvolution, Inc. All rights reserved.
//

#import "UIECLViewManager.h"
#import "GlobalData.h"

@implementation UIECLView

@synthesize mID;
@synthesize mCache;
@synthesize mViewController;

-(id) initViewWithID:(NSString*)ID
{
    if((self = [super init]))
    {
        mID = ID;
        mCache = NO;
        if([ID isEqualToString:SPLASH_SCREEN])
        {
            mViewController = [[SplashScreen alloc] initWithNibName:ID bundle:nil];
        }
        else if([ID isEqualToString:HOME])
        {
            mViewController = [[Home alloc] initWithNibName:ID bundle:nil];
        }
        
        if(VIEW_DEBUG)
        {
            if(mViewController == nil)
            {
                NSLog(@"Failed to create view controller: %@",ID);
            }
        }
    }
    return self;
}

-(void) dealloc
{
    mID = nil;
    mViewController = nil;
}

@end

@implementation UIECLViewTool

@synthesize mNavController;
@synthesize mViewStack;
@synthesize mViewCache;
@synthesize mCustomTransition;
@synthesize mTransitionDuration;

-(id) init
{
    if((self = [super init]))
    {
        mViewStack = [NSMutableArray array];
        mViewCache = [NSMutableArray array];
        
        mCustomTransition = @"";
        
        mTransitionDuration = 0.5f;
    }
    return self;
}
-(void) pushView:(NSString*)ID animated:(BOOL)anim
{
    UIECLView* newView = nil;
    
    for(UIECLView* view in mViewCache)
    {
        if([view.mID isEqualToString:ID])
        {
            newView = view;
            if(VIEW_DEBUG)
            {
                NSLog(@"Pushing Cached View: %@",newView.mID);
            }
        }
    }
    if(newView == nil)
    {
        newView = [[UIECLView alloc] initViewWithID:ID];
        [mViewStack addObject:newView];
        if(VIEW_DEBUG)
        {
            NSLog(@"Using New View: %@",newView.mID);
        }
    }
    if(![mCustomTransition isEqualToString:@""])
    {
        anim = NO;
        [self setTransition:mCustomTransition];
    }
    [mNavController pushViewController:newView.mViewController animated:anim];
    if(PRINT_VIEW_STACK)
    {
        [self printViewStack];
    }
}
-(void) pushViewCached:(NSString*)ID animated:(BOOL)anim
{
    UIECLView* newView = nil;
    [self pushView:ID animated:anim];
    newView = [mViewStack lastObject];
    newView.mCache = YES;
    if(VIEW_DEBUG)
    {
        NSLog(@"-View Cached");
    }
}
-(void) popView:(BOOL)anim
{
    UIECLView* view = [mViewStack lastObject];
    if(view.mCache == YES)
    {
        [mViewCache addObject:view];
        if(VIEW_DEBUG)
        {
            NSLog(@"Moving View to Cache: %@",view.mID);
        }
    }
    if(VIEW_DEBUG)
    {
        NSLog(@"Removing View From Stack: %@",view.mID);
    }
    if(![mCustomTransition isEqualToString:@""])
    {
        anim = NO;
        [self setTransition:mCustomTransition];
    }
    [mViewStack removeObject:view];
    [mNavController popViewControllerAnimated:anim];
    if(VIEW_DEBUG)
    {
        if(mViewStack.count > 0)
        {
            UIECLView* currentView = [mViewStack objectAtIndex:mViewStack.count-1];
            NSLog(@"Current View: %@",currentView.mID);
        }
    }
    if(PRINT_VIEW_STACK)
    {
        [self printViewStack];
    }
}
-(void) replaceView:(NSString*)ID animated:(BOOL)anim
{
    [self popView:NO];
    [self pushView:ID animated:anim];
    if(VIEW_DEBUG)
    {
        NSLog(@"Replacing Current View With: %@",ID);
    }
    if(PRINT_VIEW_STACK)
    {
        [self printViewStack];
    }
}
-(void) replaceViewCached:(NSString*)ID animated:(BOOL)anim
{
    UIECLView* newView = nil;
    [self replaceView:ID animated:anim];
    newView = [mViewStack lastObject];
    newView.mCache = YES;
    if(VIEW_DEBUG)
    {
        NSLog(@"-View Cached");
    }
}
-(void) popTo:(NSString*)ID animated:(BOOL)anim
{
    UIViewController* desiredController;
    for(UIECLView* view in mViewStack)
    {
        if([view.mID isEqualToString:ID])
        {
            desiredController = view.mViewController;
        }
    }
    if(desiredController == nil)
    {
        if(VIEW_DEBUG)
        {
            NSLog(@"Desired View is not on the Stack: %@",ID);
            if(PRINT_VIEW_STACK)
            {
                [self printViewStack];
            }
        }
        return;
    }
    
    int Count = [mNavController viewControllers].count;
    
    UIViewController* currentController = [[mNavController viewControllers] objectAtIndex:Count - 1];
    while(currentController != desiredController)
    {
        Count = [mNavController viewControllers].count;
        
        currentController = [[mNavController viewControllers] objectAtIndex:Count - 1];
        UIViewController* nextViewController = [[mNavController viewControllers] objectAtIndex:Count - 2];
        
        if(nextViewController == desiredController)
        {
            [self popView:anim];
            break;
        }
        else
        {
            [self popView:NO];
        }
    }
}
-(void) popToIndex:(int)index animated:(BOOL)anim
{
    int Counter = mViewStack.count;
    if(Counter < index || index < 0)
    {
        if(VIEW_DEBUG)
        {
            NSLog(@"Invalid Index requested");
        }
    }
    for(int i = Counter; i > index; --i)
    {
        if(i - 1 == index)
        {
            [self popView:anim];
        }
        else
        {
            [self popView:NO];
        }
    }
}
-(void) popToView:(UIECLView*)view animated:(BOOL)anim
{
    UIECLView* desiredController;
    for(UIECLView* v in mViewStack)
    {
        if(v == view)
        {
            desiredController = v;
        }
    }
    if(desiredController == nil)
    {
        if(VIEW_DEBUG)
        {
            NSLog(@"Desired View is not on the Stack: %@",view.mID);
            if(PRINT_VIEW_STACK)
            {
                [self printViewStack];
            }
        }
        return;
    }
    
    int Count = [mNavController viewControllers].count;
    
    UIViewController* currentController = [[mNavController viewControllers] objectAtIndex:Count - 1];
    while(currentController != desiredController.mViewController)
    {
        Count = [mNavController viewControllers].count;
        
        currentController = [[mNavController viewControllers] objectAtIndex:Count - 1];
        UIViewController* nextViewController = [[mNavController viewControllers] objectAtIndex:Count - 2];
        
        if(nextViewController == desiredController.mViewController)
        {
            [self popView:anim];
            break;
        }
        else
        {
            [self popView:NO];
        }
    }
}
-(void) clearCachedViews
{
    [mViewCache removeAllObjects];
    if(VIEW_DEBUG)
    {
        NSLog(@"Cached View Cleared");
    }
}
-(void) removeViewFromCache:(NSString*)ID
{
    for(UIECLView* view in mViewCache)
    {
        if([view.mID isEqualToString:ID])
        {
            if(VIEW_DEBUG)
            {
                NSLog(@"Removing View from Cache: %@",view.mID);
            }
        }
    }
}
-(void) printViewStack
{
    NSLog(@" ");
    NSLog(@"///// VIEW STACK /////");
    int Count = 0;
    NSLog(@"Stack Size: %i",[mNavController viewControllers].count - 1);
    for(UIECLView* view in mViewStack)
    {
        NSLog(@"Index: %i View: %@",Count,view.mID);
        Count++;
    }
    NSLog(@"//////////////////////");
    
    [self printViewCache];
}
-(void) printViewCache
{
    if(mViewCache.count != 0)
    {
        NSLog(@"///// VIEW CACHE /////");
        for(UIECLView* view in mViewCache)
        {
            NSLog(@"View: %@",view.mID);
        }
        NSLog(@"//////////////////////");
    }
    NSLog(@" ");
}
-(void) setTransition:(NSString*)type
{
    mCustomTransition = type;
    
    if(type == DEFAULT)
    {
        return;
    }
    
    CATransition* trans = [CATransition animation];
    [trans setDuration:mTransitionDuration];
    if(type == FADE)
    {
        [trans setType:kCATransitionFade];
        //[trans setSubtype:kCATransitionFromRight];
    }
    CALayer *layer = mNavController.view.layer;
    [layer addAnimation:trans forKey:type];

}
@end
