//
//  RootBeerTableViewController.h
//  BaseApp
//
//  Created by Blaine Anderson on 9/27/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootBeerTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIView* sortingView; 
    IBOutlet UIButton* nameButton; 
    IBOutlet UIButton* locationButton; 
}


@property(strong, nonatomic) NSMutableArray* rootList; 



-(IBAction)sort:(id)sender;
@end
