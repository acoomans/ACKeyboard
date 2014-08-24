//
//  Key.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "Key.h"
#import "UIColor+Key.h"

@interface Key ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@end


@implementation Key

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle {
    return [[self alloc] initWithKeyStyle:keyStyle];
}

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle image:(UIImage*)image {
    Key *key = [self keyWithStyle:keyStyle];
    key.image = image;
    return key;
}

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle title:(NSString*)title {
    Key *key = [self keyWithStyle:keyStyle];
    key.title = title;
    return key;
}

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.keyStyle = keyStyle;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.cornerRadius = kKeyPadCornerRadius;
        } else {
            self.cornerRadius = kKeyPhoneCornerRadius;
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithKeyStyle:KeyStyleDark];
}


#pragma mark - Properties


- (UILabel*)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _label.font = [UIFont systemFontOfSize:kKeyPadLandscapeTitleFontSize];
        } else {
            _label.font = [UIFont systemFontOfSize:kKeyPhoneTitleFontSize];
        }
        
        _label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:_label];
    }
    return _label;
}

- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (void)setTitle:(NSString *)title {
    self.label.text = title;
    [self updateState];
}

- (NSString*)title {
    return self.label.text;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self updateState];
}

- (UIImage*)image {
    return self.imageView.image;
}

- (void)setKeyStyle:(KeyStyle)keyStyle {
    _keyStyle = keyStyle;
    switch (keyStyle) {
        case KeyStyleLight: {
            self.label.textColor = [UIColor blackColor];
            break;
        }
        case KeyStyleDark: {
            self.label.textColor = [UIColor blackColor];
            break;
        }
        case KeyStyleBlue: {
            break;
        }
        default:
            break;
    }
    [self updateState];
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.label.font = titleFont;
}

- (UIFont*)titleFont {
    return self.label.font;
}


//#pragma mark - Touch tracking
//
//
//- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
//    [self updateState];
//    return result;
//}
//
//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    BOOL result = [super continueTrackingWithTouch:touch withEvent:event];
//    [self updateState];
//    return result;
//}
//
//- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    [super endTrackingWithTouch:touch withEvent:event];
//    [self updateState];
//}


#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self updateState];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self updateState];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self updateState];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self updateState];
}



#pragma mark - state

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateState];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateState];
}

- (void)updateState {
    switch (self.keyStyle) {
        case KeyStyleLight: {
            switch (self.state) {
                case UIControlStateHighlighted:
                    self.color = [UIColor darkKeyColor];
                    self.shadowColor = [UIColor darkKeyShadowColor];
                    break;
                    
                case UIControlStateNormal:
                default:
                    self.color = [UIColor lightKeyColor];
                    self.shadowColor = [UIColor lightKeyShadowColor];
                    break;
            }
            break;
        }
        case KeyStyleDark: {
            switch (self.state) {
                case UIControlStateHighlighted:
                    self.color = [UIColor lightKeyColor];
                    self.shadowColor = [UIColor lightKeyShadowColor];
                    _imageView.tintColor = [UIColor blackColor];
                    break;
                    
                case UIControlStateNormal:
                default:
                    self.color = [UIColor darkKeyColor];
                    self.shadowColor = [UIColor darkKeyShadowColor];
                    _imageView.tintColor = [UIColor whiteColor];
                    break;
            }
            break;
        }
        case KeyStyleBlue: {
            switch (self.state) {
                case UIControlStateHighlighted:
                    self.color = [UIColor lightKeyColor];
                    self.shadowColor = [UIColor lightKeyShadowColor];
                    self.label.textColor = [UIColor blackColor];
                    break;
                    
                case UIControlStateDisabled:
                    self.color = [UIColor darkKeyColor];
                    self.shadowColor = [UIColor darkKeyShadowColor];
                    self.label.textColor = [UIColor blueKeyDisabledTitleColor];
                    break;
                    
                case UIControlStateNormal:
                default:
                    self.color = [UIColor blueKeyColor];
                    self.shadowColor = [UIColor blueKeyShadowColor];
                    self.label.textColor = [UIColor whiteColor];
                    break;
            }
            break;
        }
    }
    [self setNeedsDisplay];
}


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawKeyRect:rect
                color:self.color
           withShadow:self.shadowColor];
    
}

- (void)drawKeyRect:(CGRect)rect color:(UIColor*)color {
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
    [color setFill];
    [roundedRectanglePath fill];
}

- (void)drawKeyRect:(CGRect)rect color:(UIColor*)color withShadow:(UIColor*)shadowColor {
    CGRect shadowRect = CGRectOffset(CGRectInset(rect, 0, kKeyShadowYOffset), 0, kKeyShadowYOffset);
    UIBezierPath* shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:self.cornerRadius];
    [shadowColor setFill];
    [shadowPath fill];
    
    CGRect keyRect = CGRectOffset(CGRectInset(rect, 0, kKeyShadowYOffset), 0, -kKeyShadowYOffset);
    UIBezierPath* keyPath = [UIBezierPath bezierPathWithRoundedRect:keyRect cornerRadius:self.cornerRadius];
    [color setFill];
    [keyPath fill];
}


#pragma mark - Layout


- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    return UILayoutFittingExpandedSize;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectOffset(self.bounds, 0, -1.5);
    self.imageView.frame = CGRectOffset(self.bounds, 0, -1.0);
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(MAX(self.intrinsicContentSize.width, size.width), MAX(self.intrinsicContentSize.height, size.height));
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20.0, 20.0);
}

@end
