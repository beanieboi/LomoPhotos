//
//  LomoPhotosViewController.h
//  LomoPhotos
//
//  Created by ben on 5/3/11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LomoPhotosViewController : UIViewController {
    UIButton *popularPhotos;
    UIButton *nearbyPhotos;
}

@property (nonatomic, retain) IBOutlet UIButton *popularPhotos;
@property (nonatomic, retain) IBOutlet UIButton *nearbyPhotos;

- (IBAction)doPopularPhotos;
- (IBAction)doNearbyPhotos;
@end
