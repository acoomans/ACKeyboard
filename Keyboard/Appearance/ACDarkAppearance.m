//
//  ACDarkAppearance.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 10/13/14.
//
//

#import "ACDarkAppearance.h"
#import "UIDevice+Hardware.h"


@implementation ACDarkAppearance


+ (UIColor*)ultraLightKeyColor {
    static UIColor* _ultraLightKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ultraLightKeyColor = [UIColor colorWithWhite:208/255.0 alpha:1.0];
    });
    return _ultraLightKeyColor;
}

+ (UIColor*)ultraLightKeyShadowColor {
    static UIColor* _ultraLightKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _ultraLightKeyShadowColor = [UIColor colorWithWhite:11/255.0 alpha:1.0];
        } else {
            _ultraLightKeyShadowColor = [UIColor colorWithWhite:11/255.0 alpha:1.0];
        }
    });
    return _ultraLightKeyShadowColor;
}


+ (UIColor*)lightKeyColor {
    static UIColor* _lightKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _lightKeyColor = [UIColor colorWithWhite:83/255.0 alpha:1.0];
        } else {
            _lightKeyColor = [UIColor colorWithWhite:90/255.0 alpha:1.0];
        }
    });
    return _lightKeyColor;
}

+ (UIColor*)lightKeyShadowColor {
    static UIColor* _lightKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _lightKeyShadowColor = [UIColor colorWithWhite:6.0/255.0 alpha:1.0];
        } else {
        _lightKeyShadowColor = [UIColor colorWithWhite:12.0/255.0 alpha:1.0];
        }
    });
    return _lightKeyShadowColor;
}


+ (UIColor*)darkKeyColor {
    static UIColor* _darkKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone6,"]) {
            _darkKeyColor = [UIColor colorWithWhite:53.0/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _darkKeyColor = [UIColor colorWithWhite:46.0/255.0 alpha:1.0];
        } else {
            _darkKeyColor = [UIColor colorWithWhite:52.0/255.0 alpha:1.0];
        }
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
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone5,"]) {
            _darkKeyDisabledTitleColor = [UIColor colorWithWhite:118/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _darkKeyDisabledTitleColor = [UIColor colorWithWhite:112/255.0 alpha:1.0];
        } else {
            _darkKeyDisabledTitleColor = [UIColor colorWithWhite:117/255.0 alpha:1.0];
        }
    });
    return _darkKeyDisabledTitleColor;
}

+ (UIColor*)blueKeyColor {
    static UIColor* _blueKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _blueKeyColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    });
    return _blueKeyColor;
}

+ (UIColor*)blueKeyShadowColor {
    static UIColor* _blueKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _blueKeyShadowColor = [UIColor colorWithWhite:10/255.0 alpha:1.0];
    });
    return _blueKeyShadowColor;
}

+ (UIColor*)blueKeyDisabledTitleColor {
    return [self darkKeyDisabledTitleColor];
}

@end
