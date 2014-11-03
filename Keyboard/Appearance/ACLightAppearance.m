//
//  ACLightAppearance.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 10/13/14.
//
//

#import "ACLightAppearance.h"
#import "UIDevice+Hardware.h"


@implementation ACLightAppearance

+ (UIColor*)lightKeyColor {
    static UIColor* _lightKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _lightKeyColor = [UIColor colorWithWhite:254/255.0 alpha:1.0];
        } else {
            _lightKeyColor = [UIColor whiteColor];
        }
    });
    return _lightKeyColor;
}

+ (UIColor*)lightKeyShadowColor {
    static UIColor* _lightKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _lightKeyShadowColor = [UIColor colorWithRed:142/255.0 green:145/255.0 blue:149/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone7,2"]) {
            _lightKeyShadowColor = [UIColor colorWithRed:139/255.0 green:142/255.0 blue:146/255.0 alpha:1.0];
        } else {
            _lightKeyShadowColor = [UIColor colorWithRed:136/255.0 green:138/255.0 blue:142/255.0 alpha:1.0];
        }
    });
    return _lightKeyShadowColor;
}


+ (UIColor*)darkKeyColor {
    static UIColor* _darkKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _darkKeyColor = [UIColor colorWithRed:184/255.0 green:191/255.0 blue:202/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone5,"]) {
            _darkKeyColor = [UIColor colorWithRed:174/255.0 green:179/255.0 blue:190/255.0 alpha:1.0];
        } else {
            _darkKeyColor = [UIColor colorWithRed:172/255.0 green:179/255.0 blue:190/255.0 alpha:1.0];
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
            _darkKeyDisabledTitleColor = [UIColor colorWithRed:118/255.0 green:121/255.0 blue:129/255.0 alpha:1.0];
        } else if (
                   [[[UIDevice currentDevice] machine] hasPrefix:@"iPhone6,"] ||
                   [[[UIDevice currentDevice] machine] hasPrefix:@"iPad4,"]
                   ) {
            _darkKeyDisabledTitleColor = [UIColor colorWithRed:116/255.0 green:121/255.0 blue:129/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone7,2"]) {
            _darkKeyDisabledTitleColor = [UIColor colorWithRed:116/255.0 green:121/255.0 blue:127/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone7,1"]) {
            _darkKeyDisabledTitleColor = [UIColor colorWithRed:118/255.0 green:123/255.0 blue:130/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _darkKeyDisabledTitleColor = [UIColor colorWithRed:125/255.0 green:129/255.0 blue:137/255.0 alpha:1.0];
        }
    });
    return _darkKeyDisabledTitleColor;
}


+ (UIColor*)blueKeyColor {
    static UIColor* _blueKeyColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _blueKeyColor = [UIColor colorWithRed:9/255.0 green:126/255.0 blue:254/255.0 alpha:1.0];
        } else {
            _blueKeyColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
        }
    });
    return _blueKeyColor;
}

+ (UIColor*)blueKeyShadowColor {
    static UIColor* _blueKeyShadowColor;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone5,"]) {
            _blueKeyShadowColor = [UIColor colorWithRed:105/255.0 green:106/255.0 blue:109/255.0 alpha:1.0];            
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone7,2"]) {
            _blueKeyShadowColor = [UIColor colorWithRed:103/255.0 green:105/255.0 blue:108/255.0 alpha:1.0];
        } else if ([[[UIDevice currentDevice] machine] hasPrefix:@"iPad3,"]) {
            _blueKeyShadowColor = [UIColor colorWithRed:107/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
        } else {
            _blueKeyShadowColor = [UIColor colorWithRed:104/255.0 green:106/255.0 blue:109/255.0 alpha:1.0];
        }
    });
    return _blueKeyShadowColor;
}

+ (UIColor*)blueKeyDisabledTitleColor {
    return [self darkKeyDisabledTitleColor];
}

@end
