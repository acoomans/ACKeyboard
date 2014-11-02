//
//  UIView+Search.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#import "UIView+Search.h"

@implementation UIView (Search)

- (UIView*)firstRecursiveSubviewWithClass:(Class)cls {
    UIView *result = nil;
    
    if ([self isKindOfClass:cls]) {
        result = self;
    } else {
        for (UIView *subview in self.subviews) {
            result = [subview firstRecursiveSubviewWithClass:cls];
            if (result) {
                break;
            }
        }
    }
    return result;
}

- (NSArray*)allRecursiveSubviewsWithClass:(Class)cls {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:cls]) {
            [array addObject:subview];
            [array addObjectsFromArray:[subview allRecursiveSubviewsWithClass:cls]];
        }
    }
    return array;
}

@end
