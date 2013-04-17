//
//  Home.m
//  MMATorchSpanish
//
//  Created by UIEvolution UIE10226 on 3/7/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "Home.h"
#import "RootBeerTableViewController.h"
#import "GlobalData.h"

@implementation Home


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
       
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[GlobalData sharedData].mViewManager.mNavController.navigationBarHidden=YES;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) viewWillAppear:(BOOL)animated
{
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)buttonAction:(id)sender
{
    
    [[GlobalData sharedData].mViewManager setTransition:DEFAULT];
    [[GlobalData sharedData].mViewManager pushView:RTVC animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [GlobalData sharedData].mViewManager.mNavController.navigationBarHidden=YES;
}
@end
