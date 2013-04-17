//
//  RootBeerTVCViewController.m
//  BaseApp
//
//  Created by Blaine Anderson on 10/12/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "RootBeerTVCViewController.h"
#import "GlobalData.h"

@interface RootBeerTVCViewController ()


@end

@implementation RootBeerTVCViewController
@synthesize nameButton;
@synthesize locationButton; 
@synthesize tableView;
@synthesize rootList; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GlobalData sharedData].mViewManager.mNavController.navigationBarHidden=YES;
    
    // Do any additional setup after loading the view from its nib.
    rootList = [[GlobalData sharedData] mRootList ];
     NSLog(@"RootList in view did load: %@", rootList);
    

}

- (void)viewDidUnload
{
    
    [self setLocationButton:nil];
    [self setNameButton:nil];
    [self setTableView:nil];
    [self setTabBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    rootList = [[GlobalData sharedData] mRootList ];
    NSLog(@"RootList: %@", rootList);
    // Return the number of sections.
    NSLog(@"RootList count: %i", rootList.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    rootList = [[GlobalData sharedData] mRootList ];
    // Return the number of sections.
    NSLog(@"RootList row count: %i", rootList.count);
    return rootList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rootList = [[GlobalData sharedData] mRootList ];
    NSLog(@"RootList Cell: %@", rootList);
    RootBeers* mRootBeer = [rootList objectAtIndex:indexPath.row];
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"Cell"]; 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"Cell Name: %@", mRootBeer.brewer);
    // Configure the cell...
    cell.textLabel.textColor = [UIColor brownColor];
    cell.textLabel.text = mRootBeer.name; 
    cell.detailTextLabel.text = mRootBeer.location;
    
    if (mRootBeer.isFav == TRUE) {
        cell.backgroundColor = [UIColor whiteColor]; 
    }
    
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RootBeers* mRootBeer =[rootList objectAtIndex:indexPath.row]; 
    [GlobalData sharedData].mRootBeer = mRootBeer; 
    [[GlobalData sharedData].mViewManager pushView:DETAILVIEW animated:YES]; 
    
    
    
}

- (IBAction)sort:(id)sender {
    
    rootList =[[GlobalData sharedData] mRootList];
    NSLog(@"PreSortlist: %@", rootList);
    [GlobalData sharedData].mRootList = [[GlobalData sharedData].mRootBeerParser sortRootBeer:sender];
    
    [self.tableView reloadData];
    
}

- (IBAction)goBack:(id)sender {
    [[GlobalData sharedData].mViewManager popView:YES];
}
@end


