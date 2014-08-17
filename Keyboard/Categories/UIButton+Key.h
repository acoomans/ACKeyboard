//
//  UIButton+Key.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/16/14.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonKeyStyle) {
    UIButtonKeyStyleLight,
    UIButtonKeyStyleDark,
};

@interface UIButton (Key)

+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle;
+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle image:(UIImage*)image;
+ (id)buttonWithKeyStyle:(UIButtonKeyStyle)keyStyle title:(NSString*)title;

@end
