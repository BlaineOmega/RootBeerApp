//
//  RootBeerTVCViewController.h
//  BaseApp
//
//  Created by Blaine Anderson on 10/12/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootBeerTVCViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property(strong, nonatomic) NSMutableArray* rootList; 
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

-(IBAction)sort:(id)sender;

@end
