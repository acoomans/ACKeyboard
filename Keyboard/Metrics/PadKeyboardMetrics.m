//
//  PadKeyboardMetrics.c
//  ACKeyboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#include "PadKeyboardMetrics.h"
#import "Linear.h"
#import "UIScreen+Orientation.h"


#define kPadKeyboardPortraitWidth   768.0
#define kPadKeyboardLandscapeWidth  1024.0

#define kPadKeyboardPortraitHeight 264.0
#define kPadKeyboardLandscapeHeight  352.0


PadKeyboardMetrics getPadLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight) {
    
    CGFloat edgeMargin = LINEAR_EQ(keyboardWidth,
                                   kPadKeyboardPortraitWidth, 6.0,
                                   kPadKeyboardLandscapeWidth, 7.0);
    
    CGFloat bottomMargin = LINEAR_EQ(keyboardHeight,
                                     kPadKeyboardPortraitHeight, 7.0,
                                     kPadKeyboardLandscapeHeight, 9.0);
    
    CGFloat columnMargin = LINEAR_EQ(keyboardWidth,
                                     kPadKeyboardPortraitWidth, 12.0,
                                     kPadKeyboardLandscapeWidth, 14.0);
    
    CGFloat rowMargin = LINEAR_EQ(keyboardHeight,
                                  kPadKeyboardPortraitHeight, 8.0,
                                  kPadKeyboardLandscapeHeight, 11.0);
    
    CGFloat keyHeight = LINEAR_EQ(keyboardHeight,
                                  kPadKeyboardPortraitHeight, 56.0,
                                  kPadKeyboardLandscapeHeight, 75.0);
    
    CGFloat letterKeyWidth = LINEAR_EQ(keyboardWidth,
                                       kPadKeyboardPortraitWidth, 57.0,
                                       kPadKeyboardLandscapeWidth, 78.0);
    
    
    CGFloat nextKeyboardButtonWidth = LINEAR_EQ(keyboardWidth,
                                                kPadKeyboardPortraitWidth, 90,
                                                kPadKeyboardLandscapeWidth, 122.0);
    
    CGFloat returnButtonWidth = LINEAR_EQ(keyboardWidth,
                                          kPadKeyboardPortraitWidth, 106.0,
                                          kPadKeyboardLandscapeWidth, 144.0);
    
    CGFloat rightShiftButtonWidth = LINEAR_EQ(keyboardWidth,
                                              kPadKeyboardPortraitWidth, 76.0,
                                              kPadKeyboardLandscapeWidth, 105.0);
    
    CGFloat lastRowExtraMargin =     LINEAR_EQ(keyboardHeight,
                                               kPadKeyboardPortraitHeight, 2.0,
                                               kPadKeyboardLandscapeHeight, 0.0);
    
    
    CGFloat lastRowHeight = LINEAR_EQ(keyboardHeight,
                                      kPadKeyboardPortraitHeight, 58.0,
                                      kPadKeyboardLandscapeHeight, 75.0);
    
    CGFloat deleteButtonWidth = LINEAR_EQ(keyboardWidth,
                                          kPadKeyboardPortraitWidth, 61.0,
                                          kPadKeyboardLandscapeWidth, 80.0);
    
    PadKeyboardMetrics metrics = {
        
        .nextKeyboardButtonFrame = {
            edgeMargin,
            keyboardHeight - bottomMargin - keyHeight,
            nextKeyboardButtonWidth,
            keyHeight
        },
        
        .returnButtonFrame = {
            keyboardWidth - edgeMargin - returnButtonWidth,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight + rowMargin + keyHeight),
            returnButtonWidth,
            keyHeight
        },
        
        .spaceButtonFrame = {
            edgeMargin + nextKeyboardButtonWidth + columnMargin,
            keyboardHeight - bottomMargin - keyHeight,
            keyboardWidth - (edgeMargin + nextKeyboardButtonWidth + columnMargin + edgeMargin),
            keyHeight
        },
        
        .deleteButtonFrame = {
            keyboardWidth - edgeMargin - deleteButtonWidth,
            keyboardHeight - (bottomMargin + \
                              keyHeight + rowMargin + \
                              keyHeight + rowMargin + \
                              keyHeight + rowMargin + \
                              keyHeight + \
                              lastRowExtraMargin),
            deleteButtonWidth,
            lastRowHeight
        },
        
        .leftShiftButtonFrame = {
            edgeMargin,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight),
            LINEAR_EQ(keyboardWidth,
                      kPadKeyboardPortraitWidth, 56.0,
                      kPadKeyboardLandscapeWidth, 77.0),
            keyHeight
        },
        
        .rightShiftButtonFrame = {
            keyboardWidth - edgeMargin - rightShiftButtonWidth,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight),
            rightShiftButtonWidth,
            keyHeight
        },
        
        .yoButton = {
            (keyboardWidth - letterKeyWidth)/2,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight + rowMargin + keyHeight),
            letterKeyWidth,
            keyHeight
        },
        
        .cornerRadius = ACInterfaceOrientationIsPortrait() ? 5.0 : 7.0,
        
    };
    return metrics;
}