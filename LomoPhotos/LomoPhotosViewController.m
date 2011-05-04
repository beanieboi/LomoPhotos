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

-(void)loadPopularPhotos
{
    // Build the string to call the Flickr API
    NSString *urlString = 
    [NSString stringWithFormat:
     @"http://api.lomography.com/v1/photos/popular?api_key=%@", LomoApiKey];

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

    for (NSDictionary *photo in photos)
    {
        //NSLog(@"PHOTO ID %@", [photo objectForKey:@"id"]);
        NSString *photoURLString = [[[photo objectForKey:@"assets"] objectForKey:@"large"] objectForKey:@"url"];
        
        //[photoURLsLargeImage addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
    }
    
    [self nextImage];
}

- (void)nextImage
{
    int value = [currentPhoto intValue];
    currentPhoto = [NSNumber numberWithInt:value + 1];
    [self performSelector:@selector(showZoomedImage:) withObject:currentPhoto afterDelay:0.1];
}

- (void)showZoomedImage:(NSNumber *)index
{
    NSLog(@"show photo at index %i", [index integerValue]);
    // Remove from view (and release)
    if ([fullImageViewController superview])
        [fullImageViewController removeFromSuperview];

    fullImageViewController = [[FullImageView alloc] initWithURL:[photoURLsLargeImage objectAtIndex:[index integerValue]]];
    
    [self.view addSubview:fullImageViewController];
    
    // Slide this view off screen
    CGRect frame = fullImageViewController.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.45];
    
    // Slide the image to its new location (onscreen)
    frame.origin.x = 0;
    fullImageViewController.frame = frame;
    
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [self nextImage];
    
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [[self currentPhoto] initWithInt:-1];
    photoLargeImageData = [[NSMutableArray alloc] init];
    photoURLsLargeImage = [[NSMutableArray alloc] init];

    [self loadPopularPhotos];
    [super viewDidLoad];
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
