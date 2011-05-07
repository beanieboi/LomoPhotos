//
//  Photo.h
//  LomoPhotos
//
//  Created by ben on 5/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject {
    BOOL        *imageLoaded;
    NSData      *image;
    NSURL       *url;
    NSString    *title;
    NSString    *camera;
    NSString    *film;
}

@property (nonatomic, retain) NSData* image;
@property (nonatomic, retain) NSURL*    url;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* camera;
@property (nonatomic, retain) NSString* film;

@end
