//
//  MapViewController.m
//  LomoPhotos
//
//  Created by ben on 09.05.11.
//  Copyright 2011. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Photo.h"
#import "Constants.h"
#import "MapAnnotation.h"

@implementation MapViewController

@synthesize didZoomToUser;

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - HTTP Stuff

-(void)loadNearbyPhotos:(MKCoordinateRegion)region {

    NSNumber* latitude_east = [NSNumber numberWithFloat:region.center.latitude - region.span.latitudeDelta / 2];
    NSNumber* latitude_west = [NSNumber numberWithFloat:region.center.latitude + region.span.latitudeDelta / 2];

    NSNumber* longitude_north = [NSNumber numberWithFloat:region.center.longitude + region.span.longitudeDelta / 2];
    NSNumber* longitude_south = [NSNumber numberWithFloat:region.center.longitude - region.span.longitudeDelta / 2];

    NSString *urlString = [NSString stringWithFormat:@"http://api.lomography.com/v1/location/within/%f/%f/%f/%f/photos/popular.json?api_key=%@",
                                                        [latitude_west floatValue], [longitude_north floatValue], [latitude_east floatValue], [longitude_south floatValue],  LomoApiKey];

    // Create NSURL string from formatted string
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"loading %@", urlString);
    // Setup and start async download
    responseData = [NSMutableData data];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *err;
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingMutableLeaves error:&err];
    
    NSArray *photos = [json valueForKey:@"photos"];
    for (NSDictionary *photo in photos) {
        
        Photo *_photo = [[Photo alloc] initWithJSON:photo];
        [photoList addObject:_photo];
        
        MapAnnotation* annotation = [[MapAnnotation alloc] initWithPhoto:_photo];
        //[[self view] addAnnotation:annotation];
    }

    NSLog(@"photos %d", [photoList count]);
    
}

- (void)mapView:(MKMapView *)mv regionDidChangeAnimated:(BOOL)animated {
    [self loadNearbyPhotos:mv.region];
}

#pragma mark - MapKit Stuff
- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (didZoomToUser == FALSE) {
        MKCoordinateRegion region;
        MKCoordinateSpan span;

        span.latitudeDelta=1;
        span.longitudeDelta=1;

        CLLocationCoordinate2D location = mv.userLocation.coordinate;

        region.span=span;
        region.center=location;
        [mv setRegion:region animated:TRUE];
        [mv regionThatFits:region];
        didZoomToUser = TRUE;
    }


}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    BOOL didZoomToUser = FALSE;
    photoList = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
