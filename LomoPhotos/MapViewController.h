//
//  MapViewController.h
//  LomoPhotos
//
//  Created by ben on 09.05.11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    NSMutableData   *responseData;
    NSMutableArray  *photoList;
    BOOL            didZoomToUser;
}

@property (readwrite) BOOL didZoomToUser;

@end
