//
//  Key.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>

#define kKeyStyleLightKeyColor [UIColor colorWithWhite:254/255.0 alpha:1.0]
#define kKeyStyleLightShadowColor [UIColor colorWithRed:139/255.0 green:142/255.0 blue:146/255.0 alpha:1.0]

#define kKeyStyleDarkKeyColor [UIColor colorWithRed:183/255.0 green:191/255.0 blue:202/255.0 alpha:1.0]
#define kKeyStyleDarkShadowColor kKeyStyleLightShadowColor
#define kKeyStyleDarkDisabledTitleColor [UIColor colorWithRed:124/255.0 green:129/255.0 blue:137/255.0 alpha:1.0]

#define kKeyStyleBlueKeyColor [UIColor colorWithRed:9/255.0 green:126/255.0 blue:254/255.0 alpha:1.0]
#define kKeyStyleBlueShadowColor [UIColor colorWithRed:107/255.0 green:109/255.0 blue:112/255.0 alpha:1.0]
#define kKeyStyleBlueDisabledTitleColor kKeyStyleDarkDisabledTitleColor


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
