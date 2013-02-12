//
//  CSViewController.m
//  CSLocationTestKit
//
//  Created by rachel parsons on 1/29/13.
//  Copyright (c) 2013 Cardinal Solutions. All rights reserved.
//

#import "CSGMainViewController.h"
#import "CSGMapViewController.h"
#import "CSGLocationManager.h"

@interface CSGMainViewController (){
    BOOL _locationReceived;
}

@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;

@property (strong, nonatomic) CSGMapViewController *mapController;
@property (strong, nonatomic) CSGLocationManager *locationManager;

@end

@implementation CSGMainViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if(self){
        _locationManager = [[CSGLocationManager alloc] init];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newLocationWasReceived:) name:LOCATION_UPDATED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationTrackingStopped) name:LOCATION_TRACKING_STOPPED object:nil];

    [_locationManager startLocationTracking];

    self.title = @"Location Testing";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOCATION_UPDATED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOCATION_TRACKING_STOPPED object:nil];
}

-(IBAction)mapButtonDidTouchUpInside:(id)sender{
    self.mapController = [[CSGMapViewController alloc] initWithNibName:@"CSGMapViewController" bundle:nil];
    self.mapController.isMonitoring = NO;
    self.mapController.locationManager = self.locationManager;
    [self.navigationController pushViewController:self.mapController animated:YES];
}

-(void)newLocationWasReceived:(NSNotification *)notification{
    _locationReceived = YES;

    NSDictionary *info = [notification userInfo];
    CLLocation *location = info[kCurrentLocationKey];

    self.currentLocationLabel.text = [NSString stringWithFormat:@"%f, %f", location.coordinate.latitude, location.coordinate.longitude];
}

-(void)locationTrackingStopped{
    if(!_locationReceived)
        self.currentLocationLabel.text = @"No location could be found";
}

@end
