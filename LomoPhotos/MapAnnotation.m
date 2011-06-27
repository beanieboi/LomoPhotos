//
//  MapAnnotation.m
//  LomoPhotos
//
//  Created by ben on 5/11/11.
//  Copyright 2011. All rights reserved.
//

#import "MapAnnotation.h"
#import <MapKit/MapKit.h>

@implementation MapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

#pragma mark -
#pragma mark NSObject



#pragma mark -
#pragma mark Initializers

- (MapAnnotation *)initWithPhoto:(Photo *)aPhoto {
    if (self = [super init]) {
		self.coordinate = [[aPhoto coordinate] coordinate];
		self.title = [aPhoto title];
	}

	return self;
}

@end
