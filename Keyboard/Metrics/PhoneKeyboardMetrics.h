//
//  PhoneKeyboardMetrics.h
//  Yoboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#import <CoreGraphics/CoreGraphics.h>

typedef struct {
    
    CGRect yoButton;

    CGRect leftShiftButtonFrame;
    CGRect deleteButtonFrame;

    CGRect nextKeyboardButtonFrame;
    CGRect spaceButtonFrame;
    CGRect returnButtonFrame;
    
} PhoneKeyboardMetrics;

PhoneKeyboardMetrics getPhoneLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight);