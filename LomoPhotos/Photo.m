//
//  Photo.m
//  LomoPhotos
//
//  Created by ben on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize imageLoaded;
@synthesize imageData;
@synthesize url;
@synthesize title;
@synthesize camera;
@synthesize film;

- (id)initWithJSON:(NSDictionary *)json {
    if (self = [super init]) {
        self.url = [[[json objectForKey:@"assets"] objectForKey:@"large"] objectForKey:@"url"];
        self.imageLoaded = false;
        self.imageData = [[NSMutableData data] retain];
    }
    return self;  
}

- (NSMutableData* )imageDataOrLoad {
    if (self.imageLoaded == FALSE) {
        NSURL *urlToLoad = [NSURL URLWithString:self.url];
        self.imageData = [NSData dataWithContentsOfURL:urlToLoad];
        self.imageLoaded = TRUE;
    }

    return self.imageData;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[imageData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[imageData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//NSString *responseString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
	[imageData release];
}
@end
