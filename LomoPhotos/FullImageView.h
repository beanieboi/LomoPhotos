//
//  FullImageView.h
//  LomoPhotos
//
//  Created by ben on 04.05.11.
//  Copyright 2011 innomind. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FullImageView : UIView {
    UIImageView *fullsizeImage;
}

- (void)slideViewOffScreenRight;
- (void)slideViewOffScreenLeft;
- (id)initWithURL:(NSURL *)url;

@end
