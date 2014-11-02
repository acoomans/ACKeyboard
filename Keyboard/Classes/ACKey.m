//
//  ACKey.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "ACKey.h"
#import "ACLightAppearance.h"
#import "ACDarkAppearance.h"

static CGFloat kKeyPhoneDefaultCornerRadius = 4.0;
static CGFloat kKeyPadDefaultCornerRadius = 5.0;


@interface ACKey ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *shadowColor;
@end


@implementation ACKey

+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance {
    ACKey *key = [[self alloc] initWithKeyStyle:style appearance:appearance];
    [key updateState];
    return key;
}

+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance image:(UIImage*)image {
    ACKey *key = [self keyWithStyle:style appearance:(KeyAppearance)appearance];
    key.image = image;
    return key;
}

+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance title:(NSString*)title {
    ACKey *key = [self keyWithStyle:style appearance:(KeyAppearance)appearance];
    key.title = title;
    return key;
}

- (instancetype)initWithKeyStyle:(KeyStyle)style appearance:(KeyAppearance)appearance {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.style = style;
        self.appearance = appearance;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.cornerRadius = kKeyPadDefaultCornerRadius;
        } else {
            self.cornerRadius = kKeyPhoneDefaultCornerRadius;
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithKeyStyle:KeyStyleDark appearance:KeyAppearanceLight];
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

- (void)setKeyStyle:(KeyStyle)style {
    if (_style == style) {
        return;
    }
    _style = style;
    [self updateState];
}

- (void)setAppearance:(KeyAppearance)appearance {
    if (_appearance == appearance) {
        return;
    }
    _appearance = appearance;
    [self updateState];
}

- (void)setTitleFont:(UIFont *)titleFont {
    self.label.font = titleFont;
}

- (UIFont*)titleFont {
    return self.label.font;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius == _cornerRadius) {
        return;
    }
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}


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
    
    switch (self.appearance) {
            
        case KeyAppearanceDark: {
            switch (self.style) {
                case KeyStyleLight: {
                    self.label.textColor = [UIColor whiteColor];
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACDarkAppearance darkKeyColor];
                            self.shadowColor = [ACDarkAppearance darkKeyShadowColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACDarkAppearance lightKeyColor];
                            self.shadowColor = [ACDarkAppearance lightKeyShadowColor];
                            break;
                    }
                    break;
                }
                case KeyStyleDark: {
                    self.label.textColor = [UIColor whiteColor];
//                    _imageView.image = [_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                    _imageView.tintColor = [DarkAppearance whiteColor];
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACDarkAppearance lightKeyColor];
                            self.shadowColor = [ACDarkAppearance lightKeyShadowColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACDarkAppearance darkKeyColor];
                            self.shadowColor = [ACDarkAppearance darkKeyShadowColor];
                            break;
                    }
                    break;
                }
                case KeyStyleBlue: {
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACDarkAppearance lightKeyColor];
                            self.shadowColor = [ACDarkAppearance lightKeyShadowColor];
                            self.label.textColor = [ACDarkAppearance blackColor];
                            break;
                            
                        case UIControlStateDisabled:
                            self.color = [ACDarkAppearance darkKeyColor];
                            self.shadowColor = [ACDarkAppearance darkKeyShadowColor];
                            self.label.textColor = [ACDarkAppearance blueKeyDisabledTitleColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACDarkAppearance blueKeyColor];
                            self.shadowColor = [ACDarkAppearance blueKeyShadowColor];
                            self.label.textColor = [UIColor whiteColor];
                            break;
                    }
                    break;
                }
            }
            break;
        }
            
        case KeyAppearanceLight:
        default: {
            
            switch (self.style) {
                case KeyStyleLight: {
                    self.label.textColor = [UIColor blackColor];
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACLightAppearance darkKeyColor];
                            self.shadowColor = [ACLightAppearance darkKeyShadowColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACLightAppearance lightKeyColor];
                            self.shadowColor = [ACLightAppearance lightKeyShadowColor];
                            break;
                    }
                    break;
                }
                case KeyStyleDark: {
                    self.label.textColor = [UIColor blackColor];
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACLightAppearance lightKeyColor];
                            self.shadowColor = [ACLightAppearance lightKeyShadowColor];
                            _imageView.tintColor = [ACLightAppearance blackColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACLightAppearance darkKeyColor];
                            self.shadowColor = [ACLightAppearance darkKeyShadowColor];
                            _imageView.tintColor = [ACLightAppearance whiteColor];
                            break;
                    }
                    break;
                }
                case KeyStyleBlue: {
                    switch (self.state) {
                        case UIControlStateHighlighted:
                            self.color = [ACLightAppearance lightKeyColor];
                            self.shadowColor = [ACLightAppearance lightKeyShadowColor];
                            self.label.textColor = [ACLightAppearance blackColor];
                            break;
                            
                        case UIControlStateDisabled:
                            self.color = [ACLightAppearance darkKeyColor];
                            self.shadowColor = [ACLightAppearance darkKeyShadowColor];
                            self.label.textColor = [ACLightAppearance blueKeyDisabledTitleColor];
                            break;
                            
                        case UIControlStateNormal:
                        default:
                            self.color = [ACLightAppearance blueKeyColor];
                            self.shadowColor = [ACLightAppearance blueKeyShadowColor];
                            self.label.textColor = [ACLightAppearance whiteColor];
                            break;
                    }
                    break;
                }
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
    
    // counter-clockwise
    UIBezierPath* shadowPath = [UIBezierPath bezierPath];
    
    // bottom left 1
    [shadowPath moveToPoint:CGPointMake(0.0, shadowRect.size.height - self.cornerRadius)];
    
    // bottom left 2
    [shadowPath addCurveToPoint:CGPointMake(self.cornerRadius, shadowRect.size.height)
                  controlPoint1:CGPointMake(0.0, shadowRect.size.height - self.cornerRadius/2)
                  controlPoint2:CGPointMake(self.cornerRadius/2, shadowRect.size.height)];
    
    // bottom right 1
    [shadowPath addLineToPoint:CGPointMake(shadowRect.size.width - self.cornerRadius, shadowRect.size.height)];
    
    // bottom right 2
    [shadowPath addCurveToPoint:CGPointMake(shadowRect.size.width, shadowRect.size.height - self.cornerRadius)
                  controlPoint1:CGPointMake(shadowRect.size.width - self.cornerRadius/2, shadowRect.size.height)
                  controlPoint2:CGPointMake(shadowRect.size.width, shadowRect.size.height - self.cornerRadius/2)];
    
    // top right 1
    [shadowPath addLineToPoint:CGPointMake(shadowRect.size.width, shadowRect.size.height - self.cornerRadius - kKeyShadowYOffset)];
    
    // top right 2
    [shadowPath addCurveToPoint:CGPointMake(shadowRect.size.width - self.cornerRadius, shadowRect.size.height - kKeyShadowYOffset)
                  controlPoint1:CGPointMake(shadowRect.size.width, shadowRect.size.height - kKeyShadowYOffset - self.cornerRadius/2)
                  controlPoint2:CGPointMake(shadowRect.size.width - self.cornerRadius/2, shadowRect.size.height - kKeyShadowYOffset)];
    
    // top left 1
    [shadowPath addLineToPoint:CGPointMake(self.cornerRadius, shadowRect.size.height - kKeyShadowYOffset)];
    
    // top left 2
    [shadowPath addCurveToPoint:CGPointMake(0.0, shadowRect.size.height - self.cornerRadius - kKeyShadowYOffset)
                  controlPoint1:CGPointMake(self.cornerRadius/2, shadowRect.size.height - kKeyShadowYOffset)
                  controlPoint2:CGPointMake(0.0, shadowRect.size.height - self.cornerRadius/2 - kKeyShadowYOffset)];
    
    // bottom left 1
    [shadowPath addLineToPoint:CGPointMake(0.0, shadowRect.size.height - self.cornerRadius)];
    
    [shadowPath closePath];
    [shadowPath applyTransform:CGAffineTransformMakeTranslation(0, kKeyShadowYOffset*2)];
    [shadowColor setFill];
    [shadowPath fill];
    
    CGRect keyRect = CGRectOffset(CGRectInset(rect, 0, kKeyShadowYOffset/2), 0, -kKeyShadowYOffset/2);
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
    self.label.frame = CGRectOffset(self.bounds, 0, kKeyLabelOffsetY);
    self.imageView.frame = CGRectOffset(self.bounds, 0, kKeyImageOffsetY);
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(MAX(self.intrinsicContentSize.width, size.width), MAX(self.intrinsicContentSize.height, size.height));
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20.0, 20.0);
}

@end
