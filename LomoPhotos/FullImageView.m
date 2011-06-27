////
//  FullImageView.m
//  LomoPhotos
//
//  Created by ben on 04.05.11.
//  Copyright 2011. All rights reserved.
//

#import "FullImageView.h"
#import "Photo.h"
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

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer  {
    /* Get the rotation angle in degrees */
    float RotationinDegrees = recognizer.rotation * (180/M_PI);

    if (RotationinDegrees > 50.0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //[self ]
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        [UIView commitAnimations];
        NSLog(@"RotationinDegrees %f", RotationinDegrees);
    } else if (RotationinDegrees < -50.0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //[self ]
        self.transform = CGAffineTransformMakeRotation(-M_PI/2);
        self.transform = CGAffineTransformMakeRotation(-M_PI/2);
        [UIView commitAnimations];
        NSLog(@"RotationinDegrees %f", RotationinDegrees);
    }
}

#pragma mark -
#pragma mark Initialization

- (id)initWithPhoto:(Photo *)photo {
    if (self = [super init]) {
        // Create the view offscreen (to the right)
        self.frame = CGRectMake(1024, 0, 1024, 768);

        // Setup image
        imageView = [[UIImageView alloc] initWithImage:
                                        [UIImage imageWithData:[photo imageDataOrLoad]]];

        [imageView setFrame:[[UIScreen mainScreen] bounds]];
        imageView.userInteractionEnabled = YES;

        UIRotationGestureRecognizer *recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
        [imageView addGestureRecognizer:recognizer];
        self.alwaysBounceHorizontal = YES;
        self.contentSize = self.frame.size;
        [self addSubview:imageView];
        NSLog(@"contentSize %f", self.contentSize.width);

    }
    return self;  
}

#pragma mark -
#pragma mark Cleanup


@end
