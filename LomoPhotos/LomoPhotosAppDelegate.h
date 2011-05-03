//
//  LomoPhotosAppDelegate.h
//  LomoPhotos
//
//  Created by ben on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LomoPhotosViewController;

@interface LomoPhotosAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LomoPhotosViewController *viewController;

@end
