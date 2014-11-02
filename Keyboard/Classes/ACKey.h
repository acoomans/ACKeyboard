//
//  ACKey.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>

static CGFloat kKeyPhoneCornerRadius = 4.0;
static CGFloat kKeyPadCornerRadius = 5.0;

static CGFloat kKeyShadowYOffset = 0.5;

static CGFloat kKeyPhoneTitleFontSize = 16.0;
static CGFloat kKeyPadPortraitTitleFontSize = 18.0;
static CGFloat kKeyPadLandscapeTitleFontSize = 22.0;

static CGFloat kKeyLabelOffsetY = -1.5;
static CGFloat kKeyImageOffsetY = -0.5;

typedef NS_ENUM(NSInteger, KeyAppearance) {
    KeyAppearanceLight,
    KeyAppearanceDark,
};

typedef NS_ENUM(NSInteger, KeyStyle) {
    KeyStyleLight,
    KeyStyleDark,
    KeyStyleBlue,
};


@interface ACKey : UIControl

@property (nonatomic, assign) KeyStyle style;
@property (nonatomic, assign) KeyAppearance appearance;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIFont *titleFont;

@property (nonatomic, strong) UIImage *image;

+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance;
+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance image:(UIImage*)image;
+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance title:(NSString*)title;

- (instancetype)initWithKeyStyle:(KeyStyle)style appearance:(KeyAppearance)appearance;

@end
