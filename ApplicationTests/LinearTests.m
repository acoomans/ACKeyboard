//
//  LinearTests.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Linear.h"

@interface LinearTests : XCTestCase
@end

@implementation LinearTests

- (void)test_MATRIX_2X2_DET {
    CGFloat z = MATRIX_2X2_DET(3.0, 8.0, 4.0, 6.0);
    XCTAssertEqual(z, -14.0);
}

- (void)test_MATRIX_3X3_DET {
    CGFloat z = MATRIX_3X3_DET(6.0, 1.0, 1.0, \
                               4.0, -2.0, 5.0, \
                               2.0, 8.0, 7.0);
    XCTAssertEqual(z, -306.0);
}

- (void)test_MATRIX_4X4_DET {
    CGFloat z = MATRIX_4X4_DET(3.0, 2.0, 0.0, 1.0, \
                               4.0, 0.0, 1.0, 2.0, \
                               3.0, 0.0, 2.0, 1.0, \
                               9.0, 2.0, 3.0, 1.0);
    XCTAssertEqual(z, 24.0);
}


@end
