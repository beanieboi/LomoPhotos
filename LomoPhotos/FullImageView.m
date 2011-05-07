////
//  FullImageView.m
//  LomoPhotos
//
//  Created by ben on 04.05.11.
//  Copyright 2011 innomind. All rights reserved.
//

#import "FullImageView.h"

@implementation FullImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)slideViewOffScreenLeft {
    // Get the frame of this view
    CGRect frame = self.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.45];
    
    // Set view to this offscreen location
    frame.origin.x = -1024;
    self.frame = frame;
    
    // Slide view
    [UIView commitAnimations];
}

- (void)slideViewOffScreenRight {
    // Get the frame of this view
    CGRect frame = self.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.45];
    
    // Set view to this offscreen location
    frame.origin.x = 1024;
    self.frame = frame;
    
    // Slide view
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Initialization

- (id)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        // Create the view offscreen (to the right)
        self.frame = CGRectMake(1024, 0, 1024, 768);

        // Setup image
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        fullsizeImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];

        [fullsizeImage setFrame:[[UIScreen mainScreen] bounds]];
        fullsizeImage.userInteractionEnabled = YES;

        [self addSubview:fullsizeImage];
    }
    return self;  
}

#pragma mark -
#pragma mark Cleanup

- (void)dealloc {
    [fullsizeImage release];
    [super dealloc];
}

@end
