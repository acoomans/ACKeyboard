//
//  Key.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "Key.h"


UIEdgeInsets kKeyEdgeInsets = {6, 6, 6, 6};


@implementation Key

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle {
    Key *key = [[self alloc] initWithKeyStyle:keyStyle];
    return key;
}

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle image:(UIImage*)image {
    Key *key = [self keyWithStyle:keyStyle];
    [key setImage:image forState:UIControlStateNormal];
    [key sizeToFit];
    return key;
}

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle title:(NSString*)title {
    Key *key = [self keyWithStyle:keyStyle];
    [key setTitle:title forState:UIControlStateNormal];
    [key sizeToFit];
    return key;
}

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setTintColor:[UIColor blackColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self setAdjustsImageWhenDisabled:NO];
        [self setKeyStyle:keyStyle];
    }
    return self;
}

- (void)setKeyStyle:(KeyStyle)keyStyle {
    _keyStyle = keyStyle;
    switch (keyStyle) {
        case KeyStyleLight: {
            [self setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                         resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateNormal];
            [self setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                        resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        }
        case KeyStyleDark: {
            [self setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                        resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateNormal];
            [self setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                         resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        }
        case KeyStyleBlue: {
            [self setBackgroundImage:[[UIImage imageNamed:@"key-blue"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                      resizingMode:UIImageResizingModeTile]
                            forState:UIControlStateNormal];
            [self setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                                       resizingMode:UIImageResizingModeTile]
                            forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    
    [self setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kKeyEdgeInsets
                                                                              resizingMode:UIImageResizingModeTile]
                    forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor colorWithRed:124/255.0
                                        green:129/255.0
                                         blue:137/255.0
                                        alpha:1.0]
               forState:UIControlStateDisabled];
}


@end
