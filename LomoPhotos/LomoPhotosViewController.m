//
//  LomoPhotosViewController.m
//  LomoPhotos
//
//  Created by ben on 5/3/11.
//  Copyright 2011. All rights reserved.
//

#import "LomoPhotosViewController.h"
#import "PhotosViewController.h"

@implementation LomoPhotosViewController

@synthesize popularPhotos, nearbyPhotos;

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}

- (IBAction)doPopularPhotos {
    PhotosViewController *photos = [[PhotosViewController alloc] init];
    [self.view addSubview:photos.view];
}

- (IBAction)doNearbyPhotos {
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end
