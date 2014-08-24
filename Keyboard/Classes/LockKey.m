//
//  LockKey.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "LockKey.h"
#import "UIColor+Key.h"

@interface Key ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
- (UIImageView *)imageView;
- (void)updateState;
@end



@implementation LockKey

@synthesize image = _image;
@synthesize keyStyle = _keyStyle;

- (instancetype)init {
    self = [super initWithKeyStyle:KeyStyleDark];
    if (self) {
        self.locked = NO;
        self.selected = NO;
    }
    return self;
}

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle {
    return [self init];
}


#pragma mark - Properties

- (void)setKeyStyle:(KeyStyle)keyStyle {
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
    if (!self.isLocked) {
        switch (self.state) {
            case UIControlStateSelected: {
                self.color = [UIColor lightKeyColor];
                self.shadowColor = [UIColor lightKeyShadowColor];
                self.tintColor = [UIColor blackColor];
                break;
            }
            case UIControlStateNormal:
            default: {
                self.color = [UIColor darkKeyColor];
                self.shadowColor = [UIColor darkKeyShadowColor];
                self.tintColor = [UIColor whiteColor];
            }
        }
        self.imageView.image = self.image;
    } else {
        self.color = [UIColor lightKeyColor];
        self.shadowColor = [UIColor lightKeyShadowColor];
        self.imageView.image = self.lockImage;
        self.tintColor = [UIColor blackColor];
    }
    [super setNeedsDisplay];
}

@end
