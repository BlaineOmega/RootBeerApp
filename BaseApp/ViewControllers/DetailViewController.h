//
//  DetailViewController.h
//  BaseApp
//
//  Created by Blaine Anderson on 9/28/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootBeers.h"
#define kOFFSET_FOR_KEYBOARD 250.0
@interface DetailViewController : UIViewController{
    UITextView *rootBeerNotes;
}

@property (weak, nonatomic) IBOutlet UILabel *RootBeerName;
@property (weak, nonatomic) IBOutlet UILabel *RootBeerBrewer;
@property (nonatomic, retain) IBOutlet UITextView *rootBeerNotes;
@property (weak, nonatomic) IBOutlet UILabel *RootBeerDescription;
@property (weak, nonatomic) IBOutlet UILabel *RootBeerRating;
@property (weak, nonatomic) IBOutlet UILabel *RootBeerDetails;
@property (weak, nonatomic) IBOutlet UILabel *Caffiene;

@property (weak, nonatomic) IBOutlet UISwitch *favSwitch;
@property (weak, nonatomic) IBOutlet UIStepper *ratingSlider;

@property (weak, nonatomic) IBOutlet UILabel *CaneSugar;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *overallRating;

@property (weak, nonatomic) IBOutlet UIButton *sendRating;

-(IBAction)sendRating:(id)sender;
-(IBAction)hideKeyboard:(id)sender;
@end
