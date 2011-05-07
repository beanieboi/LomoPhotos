//
//  Photo.m
//  LomoPhotos
//
//  Created by ben on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize image;
@synthesize url;
@synthesize title;
@synthesize camera;
@synthesize film;

- (id)initWithJSON:(NSDictionary *)json {
    if (self = [super init]) {
        
         
        self.url = [[[json objectForKey:@"assets"] objectForKey:@"large"] objectForKey:@"url"];

    }
    return self;  
}
@end
