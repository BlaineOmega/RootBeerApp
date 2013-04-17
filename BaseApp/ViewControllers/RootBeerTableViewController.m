//
//  RootBeerTableViewController.m
//  BaseApp
//
//  Created by Blaine Anderson on 9/27/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "RootBeerTableViewController.h"
#import "GlobalData.h"

@interface RootBeerTableViewController ()

@end

@implementation RootBeerTableViewController
@synthesize rootList;
 


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //sortingView = [[UIView alloc]initWithFrame:CGRectMake(10, 0.0, 300.00, 44.0)]; 
    //locationButton  = [[UIButton alloc] initWithFrame:CGRectZero];
     
    //[sortingView addSubview:locationButton]; 
    
    
   [GlobalData sharedData].mViewManager.mNavController.navigationBarHidden=NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    
       
    [tableView reloadData];
    
    
    
    self.view = tableView;
}

- (void)viewDidUnload
{
   
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
    rootList =[[GlobalData sharedData].mRootBeerParser rootBeerList];
     NSLog(@"RootList: %@", rootList);
    // Return the number of sections.
    NSLog(@"RootList count: %i", rootList.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of sections.
     NSLog(@"RootList row count: %i", rootList.count);
    return rootList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    cell.textLabel.text = mRootBeer.name; 
    cell.detailTextLabel.text = mRootBeer.location; 

    
   
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
    
    rootList =[[GlobalData sharedData].mRootBeerParser rootBeerList];
    
    
    [[GlobalData sharedData].mRootBeerParser sortRootBeer:sender];
}
@end
