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

@property (nonatomic) NSNumber* currentPhoto;

@end
