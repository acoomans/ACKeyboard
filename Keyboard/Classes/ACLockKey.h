//
//  ACLockKey.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/17/14.
//
//

#import "ACKey.h"


/**
 * A keyboard key that can be locked.
 */
@interface ACLockKey : ACKey

/** Wether the key is in the locked or unlocked state.
 */
@property (nonatomic, assign, getter=isLocked) BOOL locked;

@property (nonatomic, strong) UIImage *image;

/** The image to display when in the lock state.
 */
@property (nonatomic, strong) UIImage *lockImage;

@end
