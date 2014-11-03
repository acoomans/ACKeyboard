//
//  ACLockKey.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "ACLockKey.h"
#import "ACLightAppearance.h"
#import "ACDarkAppearance.h"

@interface ACKey ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
- (UIImageView *)imageView;
- (void)updateState;
@end



@implementation ACLockKey

@synthesize image = _image;
@synthesize style = _style;

- (instancetype)init {
    self = [super initWithKeyStyle:ACKeyStyleDark appearance:ACKeyAppearanceLight];
    if (self) {
        self.locked = NO;
        self.selected = NO;
    }
    return self;
}

- (instancetype)initWithKeyStyle:(ACKeyStyle)style appearance:(ACKeyAppearance)appearance {
    return [self init];
}


#pragma mark - Properties

- (void)setKeyStyle:(ACKeyStyle)style {
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
        case ACKeyAppearanceDark: {
            if (!self.isLocked) {
                switch (self.state) {
                    case UIControlStateSelected: {
                        self.color = [ACDarkAppearance ultraLightKeyColor];
                        self.shadowColor = [ACDarkAppearance ultraLightKeyShadowColor];
                        self.tintColor = [ACDarkAppearance blackColor];
                        break;
                    }
                    case UIControlStateNormal:
                    default: {
                        self.color = [ACDarkAppearance darkKeyColor];
                        self.shadowColor = [ACDarkAppearance darkKeyShadowColor];
                        self.tintColor = [ACDarkAppearance whiteColor];
                    }
                }
                self.imageView.image = self.image;
            } else {
                self.color = [ACDarkAppearance ultraLightKeyColor];
                self.shadowColor = [ACDarkAppearance ultraLightKeyShadowColor];
                self.imageView.image = self.lockImage;
                self.tintColor = [UIColor blackColor];
            }
            break;
        }
         
        case ACKeyAppearanceLight:
        default: {
            if (!self.isLocked) {
                switch (self.state) {
                    case UIControlStateSelected: {
                        self.color = [ACLightAppearance lightKeyColor];
                        self.shadowColor = [ACLightAppearance lightKeyShadowColor];
                        self.tintColor = [ACLightAppearance blackColor];
                        break;
                    }
                    case UIControlStateNormal:
                    default: {
                        self.color = [ACLightAppearance darkKeyColor];
                        self.shadowColor = [ACLightAppearance darkKeyShadowColor];
                        self.tintColor = [ACLightAppearance whiteColor];
                    }
                }
                self.imageView.image = self.image;
            } else {
                self.color = [ACLightAppearance lightKeyColor];
                self.shadowColor = [ACLightAppearance lightKeyShadowColor];
                self.imageView.image = self.lockImage;
                self.tintColor = [UIColor blackColor];
            }
            break;
        }
    }

    [super setNeedsDisplay];
}

@end
