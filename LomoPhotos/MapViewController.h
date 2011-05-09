//
//  MapViewController.h
//  LomoPhotos
//
//  Created by ben on 09.05.11.
//  Copyright 2011 innomind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    MKMapView *mapView;
}

@end
