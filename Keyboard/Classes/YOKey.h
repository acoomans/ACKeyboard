//
//  YOKey.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import <UIKit/UIKit.h>


extern UIEdgeInsets kYOKeyEdgeInsets;


@interface YOKey : UIButton

+ (instancetype)keyWithimage:(UIImage*)image;
+ (instancetype)keyWithtitle:(NSString*)title;

- (instancetype)init;

@end
