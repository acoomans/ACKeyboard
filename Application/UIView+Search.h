//
//  UIView+Search.h
//  Yoboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Search)

- (UIView*)firstRecursiveSubviewWithClass:(Class)cls;
- (NSArray*)allRecursiveSubviewsWithClass:(Class)cls;

@end
