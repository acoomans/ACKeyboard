//
//  UIScreen+Orientation.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/2/14.
//
//

#import "UIScreen+Orientation.h"

@implementation UIScreen (Orientation)

- (ACInterfaceOrientation)interfaceOrientation {
    if (self.applicationFrame.size.width > self.applicationFrame.size.height) {
        return ACInterfaceOrientationLandscape;
    } else if (self.applicationFrame.size.width < self.applicationFrame.size.height) {
        return ACInterfaceOrientationPortrait;
    } else {
        return ACInterfaceOrientationUnknown;
    }
}

@end
