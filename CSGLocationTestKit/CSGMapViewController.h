//
//  CSMapViewController.h
//  CSLocationTestKit
//
//  Created by rachel parsons on 1/31/13.
//  Copyright (c) 2013 Cardinal Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CSGLocationManager.h"


@interface CSGMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) CSGLocationManager *locationManager;
@property (assign, nonatomic) BOOL isMonitoring;

@end
