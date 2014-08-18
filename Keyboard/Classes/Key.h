//
//  Key.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KeyStyle) {
    KeyStyleLight,
    KeyStyleDark,
    KeyStyleBlue,
};

extern UIEdgeInsets kKeyEdgeInsets;


@interface Key : UIButton

@property (nonatomic, assign) KeyStyle keyStyle;

+ (instancetype)keyWithStyle:(KeyStyle)keyStyle;
+ (instancetype)keyWithStyle:(KeyStyle)keyStyle image:(UIImage*)image;
+ (instancetype)keyWithStyle:(KeyStyle)keyStyle title:(NSString*)title;

- (instancetype)initWithKeyStyle:(KeyStyle)keyStyle;

@end
