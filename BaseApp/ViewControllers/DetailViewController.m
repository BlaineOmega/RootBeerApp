//
//  DetailViewController.m
//  BaseApp
//
//  Created by Blaine Anderson on 9/28/12.
//  Copyright (c) 2012 UIEvolution, Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "GlobalData.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize RootBeerName;
@synthesize RootBeerBrewer;
@synthesize rootBeerNotes;
@synthesize RootBeerDescription;
@synthesize RootBeerDetails;
@synthesize Caffiene;
@synthesize favSwitch;
@synthesize ratingSlider;
@synthesize CaneSugar;
@synthesize ratingLabel;
@synthesize overallRating;
@synthesize sendRating;
@synthesize RootBeerRating;

 


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil itemIndex:(NSNumber *)index
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
    
    UIApplication *myApp = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:myApp];
    // Do any additional setup after loading the view from its nib.
     RootBeers* currentRootBeer = [GlobalData sharedData].mRootBeer; 
     NSLog(@"Current RootBeer Cell: %@", currentRootBeer);

    rootBeerNotes.delegate = self; 
    RootBeerName.text = currentRootBeer.name; 
    RootBeerBrewer.text = currentRootBeer.location; 
    RootBeerDescription.text = currentRootBeer.description;
    RootBeerDetails.text = currentRootBeer.details; 
    rootBeerNotes.text = nil; 
    RootBeerRating.text = @"3";
    if([currentRootBeer.caffeine isEqualToString:@"Yes"] ){
        Caffiene.text = @"Yes";
    } else {
        Caffiene.text = @"No";
    }  
    
    if([currentRootBeer.caneSugar isEqualToString:@"Yes"]){
        CaneSugar.text = @"Yes";
    } else {
        CaneSugar.text = @"No";
    }  
    
    if(currentRootBeer.isFav){
        favSwitch.on = TRUE;
        
    } else {
        favSwitch.on = FALSE; 
    }
    currentRootBeer.rating = ratingSlider.value;
    int progressAsInt = (int)(ratingSlider.value);
    NSString *newRatingText = [[NSString alloc] initWithFormat:@"%i", progressAsInt];
    ratingLabel.text=newRatingText;
    
   
    NSString *newOverallRatingText = [[NSString alloc] initWithFormat:@"%@", currentRootBeer.overallRating];

    overallRating.text = newOverallRatingText; 
}

- (void)viewDidUnload
{
    [self setRootBeerName:nil];
    [self setRootBeerBrewer:nil];
    [self setRootBeerNotes:nil];
    [self setRootBeerDescription:nil];
    [self setRootBeerRating:nil];
    [self setRootBeerDetails:nil];
    [self setCaneSugar:nil];
    [self setCaffiene:nil];
    [self setFav:nil];
    [self setFavSwitch:nil];
    [self setRatingSlider:nil];
    [self setRatingLabel:nil];
    [self setOverallRating:nil];
    [self setSendRating:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goBackOneView:(id)sender {
    [[GlobalData sharedData].mViewManager popView:TRUE]; 
}
- (IBAction)setFav:(UISwitch*) fav{
    RootBeers* currentRootBeer = [GlobalData sharedData].mRootBeer; 
    if(fav.on==TRUE){
        currentRootBeer.isFav = TRUE; 
    }
}

- (IBAction)unSetFav:(UISwitch*) fav{
    RootBeers* currentRootBeer = [GlobalData sharedData].mRootBeer; 
    if(fav.on==FALSE){
        currentRootBeer.isFav = FALSE; 
    }
}

- (IBAction)changeRating:(id)sender{
    UIStepper *slider = (UIStepper *)sender;
    int progessAsInt = (int)(slider.value);
    NSString *newText = [[NSString alloc] initWithFormat:@"%i", progessAsInt];
    ratingLabel.text=newText;
    RootBeers* currentRootBeer = [GlobalData sharedData].mRootBeer;
    currentRootBeer.rating = progessAsInt;
    [GlobalData sharedData].mRootBeer.rating = currentRootBeer.rating; 
    
}
- (IBAction)sendRating:(id)sender {
     //UISlider *slider = (UISlider *)mSlider;
    RootBeers* currentRootBeer = [GlobalData sharedData].mRootBeer; 
    // currentRootBeer.rating = slider.value;
    int tempRating = currentRootBeer.rating;
   

        NSString *string1 = [NSString stringWithFormat:@"http://blaineanderson.net/rootbeer/RootBeer/AddRating/?id=%@&rating=%i", currentRootBeer.id, tempRating];
    NSLog(@"string1: %@", string1);
    NSURL *rootBeerURL = [NSURL URLWithString:string1];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] 
                                    initWithURL:rootBeerURL];

    [request setHTTPMethod:@"GET"];
    
     [NSURLConnection connectionWithRequest:request delegate:self];
   
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Response Code: %@", response);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    NSLog(@"dataResponse Code: %@", d);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error Response Code: %@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    //NSString *responseText = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    // Do anything you want with it
   // [responseText release];
}
-(IBAction)hideKeyboard:(id)sender {
    [(UITextView*)sender resignFirstResponder];
}
-(NSString *)saveFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"rootbeerlist.plist"];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSArray *values = [[NSArray alloc] initWithObjects:rootBeerNotes.text, nil];
	[values writeToFile:[self saveFilePath] atomically:YES];
    
}
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextView *)sender
{
    
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    
}
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}
- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
-(IBAction)goBack:(id)sender{
    [[GlobalData sharedData].mViewManager popView:YES];
}
@end
