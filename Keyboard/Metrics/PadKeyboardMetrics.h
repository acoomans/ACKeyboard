//
//  PadKeyboardMetrics.h
//  Yoboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#import <CoreGraphics/CoreGraphics.h>

typedef struct {

    CGRect deleteButtonFrame;
    
    CGRect yoButton;
    
    CGRect leftShiftButtonFrame;
    CGRect rightShiftButtonFrame;
    
    CGRect nextKeyboardButtonFrame;
    CGRect spaceButtonFrame;
    CGRect returnButtonFrame;
    
} PadKeyboardMetrics;

PadKeyboardMetrics getPadLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight);
