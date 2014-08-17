//
//  LockKey.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "LockKey.h"

@implementation LockKey

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle {
    self = [super initWithKeyStyle:keyStyle];
    if (self) {
        [self setLocked:NO];
        [self setAdjustsImageWhenHighlighted:NO];
        [self setShowsTouchWhenHighlighted:NO];
        [self setAdjustsImageWhenDisabled:NO];
        [self setReversesTitleShadowWhenHighlighted:NO];
    }
    return self;
}

- (void)setKeyStyle:(KeyStyle)keyStyle {
    // disable key style
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self resetState];
}

- (void)setLocked:(BOOL)locked {
    _locked = locked;
    [self resetState];
}

- (void)resetState {
    if (!self.isLocked) {
        [self setImage:self.unlockImage forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                   resizingMode:UIImageResizingModeTile]
                        forState:UIControlStateNormal];
        
        [self setImage:self.unlockSelectedImage forState:UIControlStateSelected];
        [self setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                  resizingMode:UIImageResizingModeTile]
                        forState:UIControlStateSelected];
        
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];

    } else {
        [self setImage:self.lockImage forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                   resizingMode:UIImageResizingModeTile]
                        forState:UIControlStateNormal];
        
        [self setImage:self.lockSelectedImage forState:UIControlStateSelected];
        [self setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                  resizingMode:UIImageResizingModeTile]
                        forState:UIControlStateSelected];
        
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
        
    }
}

- (void)setUnlockImage:(UIImage *)unlockImage {
    _unlockImage = unlockImage;
    [self resetState];
}

- (void)setUnlockSelectedImage:(UIImage *)unlockSelectedImage {
    _unlockSelectedImage = unlockSelectedImage;
    [self resetState];
}

- (void)setLockImage:(UIImage *)lockImage {
    _lockImage = lockImage;
    [self resetState];
}

- (void)setLockSelectedImage:(UIImage *)lockSelectedImage {
    _lockSelectedImage = lockSelectedImage;
    [self resetState];
}

@end
