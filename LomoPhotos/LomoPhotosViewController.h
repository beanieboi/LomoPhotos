//
//  LomoPhotosViewController.h
//  LomoPhotos
//
//  Created by ben on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullImageView.h"

@interface LomoPhotosViewController : UIViewController {
    NSMutableArray  *photoTitles;         // Titles of images
    UIImageView     *fullsizeImage;
    NSMutableArray  *photoLargeImageData; // Image data
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    NSMutableData   *responseData;
    NSNumber        *currentPhoto;
    FullImageView   *fullImageViewController;
}

- (void)prevImage;
- (void)nextImage;
@property (nonatomic, retain) NSNumber* currentPhoto;

@end
