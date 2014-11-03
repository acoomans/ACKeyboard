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

/** The appearance of a key; either light or dark
 */
typedef NS_ENUM(NSInteger, ACKeyAppearance) {
    ACKeyAppearanceLight,
    ACKeyAppearanceDark,
};

/** The style of a key
 */
typedef NS_ENUM(NSInteger, ACKeyStyle) {
    ACKeyStyleLight,
    ACKeyStyleDark,
    ACKeyStyleBlue,
};


/**
 * ACKey represents a key of a keyboard.
 */
@interface ACKey : UIControl


/** @name Displaying the key */

/** The style of key.
 */
@property (nonatomic, assign) ACKeyStyle style;

/** The appearance of the key.
 */
@property (nonatomic, assign) ACKeyAppearance appearance;

/** The corner radius of a key.
 */
@property (nonatomic, assign) CGFloat cornerRadius;


/** @name Title and Image */

/** The title in the key.
 */
@property (nonatomic, copy) NSString *title;

/** The font of the title in the key.
 * @see title
 */
@property (nonatomic, copy) UIFont *titleFont;

/** The image in the key.
 */
@property (nonatomic, strong) UIImage *image;


/** @name Initializers */

/** Initialize the key with a style and appearance.
 * @param style The style of the key.
 * @param appearance The appearance of the key.
 */
+ (instancetype)keyWithStyle:(ACKeyStyle)style appearance:(ACKeyAppearance)appearance;

/** Initialize the key with a style, appearance and image.
 * @param style The style of the key.
 * @param appearance The appearance of the key.
 */
+ (instancetype)keyWithStyle:(ACKeyStyle)style appearance:(ACKeyAppearance)appearance image:(UIImage*)image;

/** Initialize the key with a style, appearance and title.
 * @param style The style of the key.
 * @param appearance The appearance of the key.
 */
+ (instancetype)keyWithStyle:(ACKeyStyle)style appearance:(ACKeyAppearance)appearance title:(NSString*)title;

/** Initialize the key with a style and appearance.
 * @param style The style of the key.
 * @param appearance The appearance of the key.
 */
- (instancetype)initWithKeyStyle:(ACKeyStyle)style appearance:(ACKeyAppearance)appearance;

@end
