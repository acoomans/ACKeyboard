//
//  ACDarkAppearance.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 10/13/14.
//
//

#import "ACDarkAppearance.h"
#import "UIDevice+Hardware.h"

#import "Metrics.h"

#define DarkAppearanceOnBlackBackground 20.0/255.0
#define DarkAppearanceOnWhiteBackground 89.0/255.0

#define DarkAppearanceAlpha(onBlack, onWhite) \
    MATRIX_SOLVE_Y(DarkAppearanceOnWhiteBackground, DarkAppearanceOnBlackBackground, 1.0, 1.0, onWhite, onBlack)
#define DarkAppearanceWhite(onBlack, onWhite) \
    MATRIX_SOLVE_X(DarkAppearanceOnWhiteBackground, DarkAppearanceOnBlackBackground, 1.0, 1.0, onWhite, onBlack)

#define DarkAppearanceColorForBlackAndWhiteBackgrounds(onBlack, onWhite) \
    [UIColor colorWithWhite:DarkAppearanceWhite(onBlack, onWhite) alpha:DarkAppearanceAlpha(onBlack, onWhite)];


@implementation ACDarkAppearance


+ (UIColor*)ultraLightKeyColor {
    static UIColor* _ultraLightKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ultraLightKeyColor = [UIColor colorWithWhite:222/255.0 alpha:1.0];
    });
    return _ultraLightKeyColor;
}

+ (UIColor*)ultraLightKeyShadowColor {
    return [self lightKeyShadowColor];
}

+ (UIColor*)lightKeyColor {
    static UIColor* _lightKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lightKeyColor = [UIColor colorWithWhite:138/255.0 alpha:1.0];
    });
    return _lightKeyColor;
}

+ (UIColor*)lightKeyShadowColor {
    static UIColor* _lightKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lightKeyShadowColor = [UIColor colorWithWhite:49.0/255.0 alpha:1.0];
    });
    return _lightKeyShadowColor;
}

+ (UIColor*)darkKeyColor {
    static UIColor* _darkKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _darkKeyColor = DarkAppearanceColorForBlackAndWhiteBackgrounds(52.0/255.0, 104.0/255.0);
    });
    return _darkKeyColor;
}

+ (UIColor*)darkKeyShadowColor {
    return [self lightKeyShadowColor];
}

+ (UIColor*)darkKeyDisabledTitleColor {
    static UIColor* _darkKeyDisabledTitleColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            _darkKeyDisabledTitleColor = [UIColor colorWithWhite:150/255.0 alpha:1.0];
    });
    return _darkKeyDisabledTitleColor;
}

+ (UIColor*)blueKeyColor {
    static UIColor* _blueKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone4,1"]) {
            _blueKeyColor = [UIColor colorWithRed:9/255.0 green:126/255.0 blue:254/255.0 alpha:1.0];
            
        } else { // iPhone5,
            _blueKeyColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
        }
    });
    return _blueKeyColor;
}

+ (UIColor*)blueKeyShadowColor {
    return [self lightKeyShadowColor];
}

+ (UIColor*)blueKeyDisabledTitleColor {
    return [self darkKeyDisabledTitleColor];
}

@end
