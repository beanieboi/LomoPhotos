//
//  PhotosViewController.h
//  LomoPhotos
//
//  Created by ben on 09.05.11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullImageView.h"

@interface PhotosViewController : UIViewController {
    NSMutableArray  *photoTitles;         // Titles of images
    UIImageView     *fullsizeImage;
    NSMutableArray  *photoList; // URL to larger image
    NSMutableData   *responseData;
    NSNumber        *currentPhoto;
    FullImageView   *fullImageView;
}

- (void)prevImage;
- (void)nextImage;
- (void)showZoomedImage:(NSArray *)indexAndDirection;

@property (nonatomic, retain) NSNumber* currentPhoto;

@end
