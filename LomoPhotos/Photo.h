//
//  Photo.h
//  LomoPhotos
//
//  Created by ben on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject {
    BOOL            imageLoaded;
    NSMutableData   *imageData;
    NSString        *url;
    NSString        *title;
    NSString        *camera;
    NSString        *film;
}

@property (nonatomic)         BOOL              imageLoaded;
@property (nonatomic, retain) NSMutableData*    imageData;
@property (nonatomic, retain) NSString*            url;
@property (nonatomic, retain) NSString*         title;
@property (nonatomic, retain) NSString*         camera;
@property (nonatomic, retain) NSString*         film;

- (id)initWithJSON:(NSDictionary *)json;
- (NSMutableData* )imageDataOrLoad;
@end