//
//  YOKey.m
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "YOKey.h"

UIEdgeInsets kYOKeyEdgeInsets = {6, 6, 6, 6};

@implementation YOKey


+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    YOKey *key = [[self alloc] init];
    return key;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setTintColor:[UIColor blackColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    }
    return self;
}

+ (instancetype)keyWithimage:(UIImage*)image {
    YOKey *key = [self buttonWithType:UIButtonTypeCustom];
    [key setImage:image forState:UIControlStateNormal];
    [key sizeToFit];
    return key;
}

+ (instancetype)keyWithtitle:(NSString*)title {
    YOKey *key = [self buttonWithType:UIButtonTypeCustom];
    [key setTitle:title forState:UIControlStateNormal];
    [key sizeToFit];
    return key;
}

@end
