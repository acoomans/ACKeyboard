//
//  LockKey.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "LockKey.h"
#import "LightAppearance.h"
#import "DarkAppearance.h"

@interface Key ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
- (UIImageView *)imageView;
- (void)updateState;
@end



@implementation LockKey

@synthesize image = _image;
@synthesize style = _style;

- (instancetype)init {
    self = [super initWithKeyStyle:KeyStyleDark appearance:KeyAppearanceLight];
    if (self) {
        self.locked = NO;
        self.selected = NO;
    }
    return self;
}

- (instancetype)initWithKeyStyle:(KeyStyle)style appearance:(KeyAppearance)appearance {
    return [self init];
}


#pragma mark - Properties

- (void)setKeyStyle:(KeyStyle)style {
    // disable key style
}

- (void)setImage:(UIImage *)image {
    _image = image;
}

- (void)setLockImage:(UIImage *)lockImage {
    _lockImage = lockImage;
}


#pragma mark - State

- (void)setLocked:(BOOL)locked {
    _locked = locked;
    [self updateState];
}

- (void)updateState {
    
    switch (self.appearance) {
        case KeyAppearanceDark: {
            if (!self.isLocked) {
                switch (self.state) {
                    case UIControlStateSelected: {
                        self.color = [DarkAppearance ultraLightKeyColor];
                        self.shadowColor = [DarkAppearance ultraLightKeyShadowColor];
                        self.tintColor = [DarkAppearance blackColor];
                        break;
                    }
                    case UIControlStateNormal:
                    default: {
                        self.color = [DarkAppearance darkKeyColor];
                        self.shadowColor = [DarkAppearance darkKeyShadowColor];
                        self.tintColor = [DarkAppearance whiteColor];
                    }
                }
                self.imageView.image = self.image;
            } else {
                self.color = [DarkAppearance ultraLightKeyColor];
                self.shadowColor = [DarkAppearance ultraLightKeyShadowColor];
                self.imageView.image = self.lockImage;
                self.tintColor = [UIColor blackColor];
            }
            break;
        }
         
        case KeyAppearanceLight:
        default: {
            if (!self.isLocked) {
                switch (self.state) {
                    case UIControlStateSelected: {
                        self.color = [LightAppearance lightKeyColor];
                        self.shadowColor = [LightAppearance lightKeyShadowColor];
                        self.tintColor = [LightAppearance blackColor];
                        break;
                    }
                    case UIControlStateNormal:
                    default: {
                        self.color = [LightAppearance darkKeyColor];
                        self.shadowColor = [LightAppearance darkKeyShadowColor];
                        self.tintColor = [LightAppearance whiteColor];
                    }
                }
                self.imageView.image = self.image;
            } else {
                self.color = [LightAppearance lightKeyColor];
                self.shadowColor = [LightAppearance lightKeyShadowColor];
                self.imageView.image = self.lockImage;
                self.tintColor = [UIColor blackColor];
            }
            break;
        }
    }

    [super setNeedsDisplay];
}

@end
