//
//  CSLocationManager.h
//  CSLocationTestKit
//
//  Created by rachel parsons on 1/30/13.
//  Copyright (c) 2013 Cardinal Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_TRACKING_STOPPED @"LOCATION_TRACKING_STOPPED"
#define LOCATION_UPDATED_NOTIFICATION @"LOCATION_UPDATED_NOTIFICATION"
#define kCurrentLocationKey @"CURRENT_LOCATION_FROM_MANAGER"
#define USER_ENTERED_REGION @"USER_ENTERED_REGION"

@interface CSGLocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocation *currentLocation;
@property (assign, nonatomic) CLLocationAccuracy accuracy;
@property (assign, nonatomic) CGFloat distance;
@property (assign, nonatomic) CGFloat trackingTime;

-(void)startLocationTracking;
-(void)stopLocationTracking;

-(void)startRegionMonitoring:(CLRegion*)region;
-(void)stopRegionMonitoring;

@end
