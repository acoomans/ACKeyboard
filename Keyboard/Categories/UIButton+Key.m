//
//  UIButton+Key.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/16/14.
//
//

#import "UIButton+Key.h"


static UIEdgeInsets kUIButtonKeyEdgeInsets = {6, 6, 6, 6};

@implementation UIButton (Key)

+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTintColor:[UIColor blackColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    
    switch (keyStyle) {
        case UIButtonKeyStyleLight: {
            [button setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kUIButtonKeyEdgeInsets
                                                                                         resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateNormal];
            [button setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kUIButtonKeyEdgeInsets
                                                                                         resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateHighlighted];
            break;
        }
        case UIButtonKeyStyleDark: {
            [button setBackgroundImage:[[UIImage imageNamed:@"key-dark"] resizableImageWithCapInsets:kUIButtonKeyEdgeInsets
                                                                                        resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateNormal];
            [button setBackgroundImage:[[UIImage imageNamed:@"key-light"] resizableImageWithCapInsets:kUIButtonKeyEdgeInsets
                                                                                         resizingMode:UIImageResizingModeTile]
                              forState:UIControlStateHighlighted];
            break;
        }
        default:
            break;
    }
    return button;
}

+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle image:(UIImage*)image {
    UIButton *button = [self buttonWithKeyStyle:keyStyle];
    [button setImage:image forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle title:(NSString*)title {
    UIButton *button = [self buttonWithKeyStyle:keyStyle];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

@end
