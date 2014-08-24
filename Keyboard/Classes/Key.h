//
//  Key.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>

static CGFloat kKeyCornerRadius = 4.0;
static CGFloat kKeyShadowYOffset = 0.5;

static CGFloat kKeyTitleFontSize = 16.0;


typedef NS_ENUM(NSInteger, KeyStyle) {
    KeyStyleLight,
    KeyStyleDark,
    KeyStyleBlue,
};


@interface Key : UIControl

@property (nonatomic, assign) KeyStyle keyStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle;
+ (instancetype)keyWithStyle:(KeyStyle)keyStyle image:(UIImage*)image;
+ (instancetype)keyWithStyle:(KeyStyle)keyStyle title:(NSString*)title;

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle;

@end
