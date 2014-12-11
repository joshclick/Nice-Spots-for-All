//
//  ViewController.m
//  Nice-Spots-for-All
//
//
//  Created by Abhijai on 12/4/14.
//  Copyright (c) 2014 abhijaigarg. All rights reserved.
//


#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "DBManager.h"


@interface MapViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrLocations;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Map";

    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _dbManager = [[DBManager alloc] initWithDatabaseFilename:@"locations.sql"];
    
    _locationNameField.hidden = YES;
    _saveLocationButton.hidden = YES;
    
    _mapView.delegate = self;
    _locationNameField.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    _mapView.showsUserLocation = YES;
    
    _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    
    [self addAnnotationsToMap];
}

- (void)addAnnotationsToMap {
    NSString *query = @"select * from locations";
    
    // Get the results.
    if (_arrLocations != nil) {
        _arrLocations = nil;
    }
    _arrLocations = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfLat = [self.dbManager.arrColumnNames indexOfObject:@"lat"];
    NSInteger indexOfLong = [self.dbManager.arrColumnNames indexOfObject:@"long"];

    //Read locations details from plist
    for (int i = 0; i < [_arrLocations count]; i++) {
        NSNumber *latitude = [[self.arrLocations objectAtIndex:i] objectAtIndex:indexOfLat];
        NSNumber *longitude = [[self.arrLocations objectAtIndex:i] objectAtIndex:indexOfLong];
        NSString *title = [[self.arrLocations objectAtIndex:i] objectAtIndex:indexOfName];
        //Create coordinates from the latitude and longitude values
        CLLocationCoordinate2D coord;
        coord.latitude = latitude.doubleValue;
        coord.longitude = longitude.doubleValue;
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = coord;
        annotation.title = title;
        
        [_mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAdd:(id)sender {
    _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    _locationNameField.hidden = NO;
    _saveLocationButton.hidden = NO;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (_mapView.centerCoordinate.latitude == 0 && _mapView.centerCoordinate.longitude == 0) {
        _mapView.centerCoordinate = _mapView.userLocation.location.coordinate;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)saveLocation:(id)sender {
    NSString *query = [NSString stringWithFormat:@"insert into locations values(null, '%@', '%f', %f)", _locationNameField.text, (double)_mapView.userLocation.location.coordinate.latitude , (double)_mapView.userLocation.location.coordinate.longitude];
    
    // Execute the query.
    [_dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (_dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", _dbManager.affectedRows);
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = _mapView.userLocation.location.coordinate;
        annotation.title = _locationNameField.text;
        
        [_mapView addAnnotation:annotation];
        
        _locationNameField.text = @"";
        _locationNameField.hidden = YES;
        _saveLocationButton.hidden = YES;
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}

@end
