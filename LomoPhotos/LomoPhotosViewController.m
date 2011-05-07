//
//  LomoPhotosViewController.m
//  LomoPhotos
//
//  Created by ben on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LomoPhotosViewController.h"
#import "JSON.h"

@implementation LomoPhotosViewController

NSString *const LomoApiKey = @"6b34051cbbbc9ed72ba14b8d31b395";

@synthesize currentPhoto;

-(void)loadPopularPhotos {
    NSString *urlString = [NSString stringWithFormat:@"http://api.lomography.com/v1/photos/popular?api_key=%@", LomoApiKey];

    // Create NSURL string from formatted string
    NSURL *url = [NSURL URLWithString:urlString];

    NSLog(@"loading %@", urlString);
    // Setup and start async download
    responseData = [[NSMutableData data] retain];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    [request release];
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
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];

	NSDictionary *results = [responseString JSONValue];
    NSArray *photos = [results objectForKey:@"photos"];

    for (NSDictionary *photo in photos) {
        
        [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
    }
    
    [self nextImage];
}

- (void)loadImage:(NSNumber *)index {
    NSURL *url = [photoURLsLargeImage objectAtIndex:[index intValue]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    [photoLargeImageData insertObject:imageData atIndex:[index intValue]];
}

- (void)nextImage {
    int value = [currentPhoto intValue];
    currentPhoto = [NSNumber numberWithInt:value + 1];
    [self performSelector:@selector(showZoomedImage:) withObject:[NSArray arrayWithObjects:currentPhoto, @"right", nil] afterDelay:0.1];
}

- (void)prevImage {
    int value = [currentPhoto intValue];
    currentPhoto = [NSNumber numberWithInt:value - 1];
    [self performSelector:@selector(showZoomedImage:) withObject:[NSArray arrayWithObjects:currentPhoto, @"left", nil] afterDelay:0.1];
}

- (void)showZoomedImage:(NSArray *)indexAndDirection {
    NSNumber *index = [indexAndDirection objectAtIndex:0];
    NSString *direction = [indexAndDirection objectAtIndex:1];
    NSLog(@"show photo at index %i", [index integerValue]);
    // Remove from view (and release)
    if ([fullImageView superview])
        [fullImageView removeFromSuperview];

    fullImageView = [[FullImageView alloc] initWithURL:[photoURLsLargeImage objectAtIndex:[index integerValue]]];
    [self.view addSubview:fullImageView];

    // Slide this view off screen

    // Slide the image to its new location (onscreen)
    if ([direction isEqualToString:@"right"]) {
        NSLog(@"FromRight");
        CGRect frame = fullImageView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.45];
        frame.origin.x = 0;
        fullImageView.frame = frame;
    } else {
        NSLog(@"FromLeft");
        CGRect frame = CGRectMake(-1024, 0, 1024, 768);
        fullImageView.frame = frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.45];
        frame.origin.x = 0;
        fullImageView.frame = frame;
        
    }

    [UIView commitAnimations];
}

- (void)handleLeftSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    [fullImageView slideViewOffScreenLeft];
    [self nextImage];
    NSLog(@"left");
}

- (void)handleRightSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    [fullImageView slideViewOffScreenRight];
    [self prevImage];
    NSLog(@"right");
}

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
- (void)viewDidLoad {
    [[self currentPhoto] initWithInt:-1];
    photoLargeImageData = [[NSMutableArray alloc] init];
    photoURLsLargeImage = [[NSMutableArray alloc] init];
    
    UISwipeGestureRecognizer *recognizerLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(handleLeftSwipeFrom:)];
    [recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizerLeft];
    [recognizerLeft release];
    
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handleRightSwipeFrom:)];
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizerRight];
    [recognizerRight release];
    
    [self loadPopularPhotos];
    [super viewDidLoad];
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
