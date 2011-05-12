//
//  MapAnnotation.h
//  LomoPhotos
//
//  Created by ben on 5/11/11.
//  Copyright 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Photo.h"

@interface MapAnnotation : NSObject <MKAnnotation> {
    
@private
    CLLocationCoordinate2D _coordinate;
    NSString * _title;
    NSString * _subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- initWithPhoto:(Photo *)aPhoto;

@end
