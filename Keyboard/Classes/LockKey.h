//
//  LockKey.h
//  Yoboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "Key.h"

@interface LockKey : Key

@property (nonatomic, assign, getter=isLocked) BOOL locked;

@property (nonatomic, strong) UIImage *unlockImage;
@property (nonatomic, strong) UIImage *unlockSelectedImage;

@property (nonatomic, strong) UIImage *lockImage;
@property (nonatomic, strong) UIImage *lockSelectedImage;

@end
