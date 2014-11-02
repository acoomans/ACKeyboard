//
//  ACLockKey.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "ACKey.h"

@interface ACLockKey : ACKey

@property (nonatomic, assign, getter=isLocked) BOOL locked;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *lockImage;

@end
