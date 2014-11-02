//
//  PadKeyboardMetrics.h
//  ACKeyboard
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
    
    CGFloat cornerRadius;
    
} PadKeyboardMetrics;

PadKeyboardMetrics getPadLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight);
