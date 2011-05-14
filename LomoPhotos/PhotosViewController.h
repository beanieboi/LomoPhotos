//
//  PhotosViewController.h
//  LomoPhotos
//
//  Created by ben on 09.05.11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullImageView.h"

@interface PhotosViewController : UIViewController <UIScrollViewDelegate> {
    UIImageView     *fullsizeImage;
    NSMutableArray  *photoList;
    NSMutableData   *responseData;
    NSNumber        *currentPhoto;
    FullImageView   *fullImageView;
}

- (void)prevImage;
- (void)nextImage;
- (void)showZoomedImage:(NSArray *)indexAndDirection;

@property (nonatomic, retain) NSNumber* currentPhoto;

@end
