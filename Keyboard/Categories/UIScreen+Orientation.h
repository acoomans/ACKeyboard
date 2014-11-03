//
//  UIScreen+Orientation.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/2/14.
//
//

#import <UIKit/UIKit.h>


#define ACInterfaceOrientationIsPortrait() \
    UIInterfaceOrientationIsPortrait([[UIScreen mainScreen] interfaceOrientation])
#define ACInterfaceOrientationIsLandscape() \
    UIInterfaceOrientationIsLandscape([[UIScreen mainScreen] interfaceOrientation])


typedef NS_ENUM(NSInteger, ACInterfaceOrientation) {
    ACInterfaceOrientationUnknown            = UIInterfaceOrientationUnknown,
    ACInterfaceOrientationPortrait           = UIInterfaceOrientationPortrait,
    //UIInterfaceOrientationPortraitUpsideDown
    //UIInterfaceOrientationLandscapeLeft
    //UIInterfaceOrientationLandscapeRight
    ACInterfaceOrientationLandscape          = UIInterfaceOrientationLandscapeLeft,
};

@interface UIScreen (Orientation)

- (ACInterfaceOrientation)interfaceOrientation;


@end
