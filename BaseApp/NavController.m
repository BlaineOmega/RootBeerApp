//
//  NavController.m
//  MMATorchSpanish
//
//  Created by UIEvolution UIE10226 on 3/7/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "NavController.h"
#import "GlobalData.h"

@implementation NavController

-(void)viewDidLoad
{
    [self setNavigationBarHidden:YES];
    [GlobalData sharedData].mViewManager.mNavController = self;
    [[GlobalData sharedData].mViewManager setTransition:FADE];
    [[GlobalData sharedData].mViewManager pushView:SPLASH_SCREEN animated:YES];
}

@end
