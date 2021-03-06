//
//  DetailsViewController.m
//  searchbar
//
//  Created by mmai on 11/27/13.
//  Copyright (c) 2013 mmai. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize delegate;

@synthesize bug;

@synthesize scrollView;
@synthesize orderLabel;
@synthesize invertebrateImage;
@synthesize nameOfBug;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // new addition
    [orderLabel setNumberOfLines:0];
    [orderLabel sizeToFit];
    
    // pjc - made descriptionLabel autosize to scroll better
    //[descriptionLabel setNumberOfLines:0];
    //[descriptionLabel sizeToFit];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, orderLabel.bounds.size.height+400)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableString *details = [[NSMutableString alloc] init];
    
    delegate = (macroinvAppDelegate *) [[UIApplication sharedApplication] delegate]; // to refer to AppDelegate methods
    
    NSString *s = [bug.imageFile stringByReplacingOccurrencesOfString:@"File:" withString:@""];
    NSArray * se = [s componentsSeparatedByString:@"."];
    UIImage *image;
    if ([se count] > 1){
        image = [delegate.webData loadImage:[se objectAtIndex:0] ofType:[se objectAtIndex:1]];
    }
    else{
        image = nil;
    }
    if(image != nil){
        //UIImage *image = [UIImage imageNamed: bug.imageFile];
        //invertebrateImage.contentMode  = UIViewContentModeScaleAspectFit;
        [invertebrateImage setImage:image];
    }
    else{
        invertebrateImage.Hidden = TRUE;
        NSLog(@"Failed to load image: %@", bug.imageFile);
    }
    //NSLog(@"Loaded %@ from %@",[image description], bug.imageFile);
    
    // if order is not there, dont show orderlabel and ordertopic
    if ([bug.order length ] > 3){
        //self.orderLabel.hidden = YES;
        //self.orderTopic.hidden = YES;
        

        NSString *topic = @"Order: ";
        NSString *value = bug.order;
        [details appendString:[topic stringByAppendingString:value]];
        
    }
    
   if ([bug.family length ] > 3){
       // self.familyTopic.hidden = YES;
       // self.familyLabel.hidden = YES;
       NSString *topic = @"\nFamily: ";
       NSString *value = bug.family;
       [details appendString:[topic stringByAppendingString:value]];
    }
    
    if ([bug.genus length ] > 3){
        NSString *topic = @"\nGenus: ";
        NSString *value = bug.genus;
        [details appendString:[topic stringByAppendingString:value]];
    }
    

    if ([bug.commonName length ] > 3){
        NSString *topic = @"\nCommon Name: ";
        NSString *value = bug.commonName;
        [details appendString:[topic stringByAppendingString:value]];
    }
    
    if ([bug.flyName length ] > 3){
        NSString *topic = @"\nFly Name: ";
        NSString *value = bug.flyName;
        [details appendString:[topic stringByAppendingString:value]];
    }
    if ([bug.description length ] > 3){
        NSString *topic = @"\nDescription: \n";
        NSString *value = bug.text;
        [details appendString:[topic stringByAppendingString:value]];
        
    }
    orderLabel.text = details;
    nameOfBug.text = bug.name;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
