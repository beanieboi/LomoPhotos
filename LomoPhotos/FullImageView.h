//
//  FullImageView.h
//  LomoPhotos
//
//  Created by ben on 04.05.11.
//  Copyright 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface FullImageView : UIScrollView {
    UIImageView *imageView;
}

- (void)slideViewOffScreenRight;
- (void)slideViewOffScreenLeft;
- (id)initWithPhoto:(Photo *)photo;

@end
