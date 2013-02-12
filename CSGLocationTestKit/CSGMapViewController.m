//
//  CSMapViewController.m
//  CSLocationTestKit
//
//  Created by rachel parsons on 1/31/13.
//  Copyright (c) 2013 Cardinal Solutions. All rights reserved.
//

#import "CSGMapViewController.h"

@interface CSGMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *watchButton;
@property (weak, nonatomic) IBOutlet UILabel *almostThereView;

@end

@implementation CSGMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(nibNameOrNil){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            self = [super initWithNibName:[NSString stringWithFormat:@"%@_iPad", nibNameOrNil] bundle:nibBundleOrNil];
        else
            self = [super initWithNibName:[NSString stringWithFormat:@"%@_iPhone", nibNameOrNil] bundle:nibBundleOrNil];
    }else
	    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Map View";
	self.mapView.delegate = self;

    MKCoordinateSpan span = MKCoordinateSpanMake(.1, .1);
    CLLocationCoordinate2D centeringCoord = self.locationManager.currentLocation.coordinate;
    self.mapView.region = MKCoordinateRegionMake(centeringCoord, span);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.showsUserLocation = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.showsUserLocation = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_ENTERED_REGION object:nil];

}

-(void)userEnteredRegion:(NSNotification*)notification{
    self.almostThereView.text = @"You're approaching the Country Club!";
    self.almostThereView.accessibilityValue = self.almostThereView.text;
    [UIView animateWithDuration:1.5 animations:^{
        self.almostThereView.alpha = 1;
    }];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:USER_ENTERED_REGION object:nil];

    self.watchButton.enabled = YES;

}

-(IBAction)watchButtonDidTouchUpInside:(id)sender{
    self.almostThereView.text = @"";
    self.almostThereView.accessibilityValue = self.almostThereView.text;
    self.almostThereView.alpha = 0;
    self.watchButton.enabled = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userEnteredRegion:) name:USER_ENTERED_REGION object:nil];

    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(40.779258, -96.688013) radius:5 identifier:@"countryClubRegion"];
    [self.locationManager startRegionMonitoring:region];
}

@end
