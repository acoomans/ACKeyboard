//
//  ACKey.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>

static CGFloat kKeyShadowYOffset = 1.0;

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


/**
 * ACKey represents a key of a keyboard
 */
@interface ACKey : UIControl


/** @name Displaying the key */

/** The style of key
 */
@property (nonatomic, assign) KeyStyle style;

/** The appearance of the key
 */
@property (nonatomic, assign) KeyAppearance appearance;

/** The corner radius of a key
 */
@property (nonatomic, assign) CGFloat cornerRadius;


/** @name Title and Image */

/** The title in the key
 */
@property (nonatomic, copy) NSString *title;

/** The font of the title in the key
 */
@property (nonatomic, copy) UIFont *titleFont;

/** The image in the key
 */
@property (nonatomic, strong) UIImage *image;


/** @name Initializers */

/** Initialize the key with a style and appearance
 */
+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance;

/** Initialize the key with a style, appearance and image
 */
+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance image:(UIImage*)image;

/** Initialize the key with a style, appearance and title
 */
+ (instancetype)keyWithStyle:(KeyStyle)style appearance:(KeyAppearance)appearance title:(NSString*)title;

/** Initialize the key with a style and appearance
 */
- (instancetype)initWithKeyStyle:(KeyStyle)style appearance:(KeyAppearance)appearance;

@end
