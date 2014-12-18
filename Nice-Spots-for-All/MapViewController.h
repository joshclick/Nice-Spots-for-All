//
//  ViewController.h
//  Nice-Spots-for-All
//
//  Created by Joshua on 12/4/14.
//  Copyright (c) 2014 joshclick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITextField *locationNameField;
@property (weak, nonatomic) IBOutlet UIButton *saveLocationButton;
- (IBAction)saveLocation:(id)sender;

@end
