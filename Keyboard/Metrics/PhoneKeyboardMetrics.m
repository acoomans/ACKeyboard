//
//  PhoneKeyboardMetrics.c
//  ACKeyboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#import "PhoneKeyboardMetrics.h"
#import "Linear.h"
#import "UIDevice+Hardware.h"


#define kPhoneKeyboardPortraitWidth     320.0
#define kPhoneKeyboardLandscapeWidth    568.0

#define kPhoneKeyboardPortraitHeight    216.0
#define kPhoneKeyboardLandscapeHeight   162.0

#define edgeMargin      3.0
#define bottomMargin    3.0


PhoneKeyboardMetrics getPhoneLinearKeyboardMetrics(CGFloat keyboardWidth, CGFloat keyboardHeight) {
    
    CGFloat rowMargin = LINEAR_EQ(keyboardHeight,
                                  kPhoneKeyboardPortraitHeight, 15.0,
                                  kPhoneKeyboardLandscapeHeight, 7.0);
    
    CGFloat columnMargin = LINEAR_EQ(keyboardWidth,
                                     kPhoneKeyboardPortraitWidth, 6.0,
                                     kPhoneKeyboardLandscapeWidth, 7.0);
    
    CGFloat keyHeight = LINEAR_EQ(keyboardHeight,
                                  kPhoneKeyboardPortraitHeight, 39.0,
                                  kPhoneKeyboardLandscapeHeight, 33.0);
    
    CGFloat letterKeyWidth = LINEAR_EQ(keyboardWidth,
                                       kPhoneKeyboardPortraitWidth, 26.0,
                                       kPhoneKeyboardLandscapeWidth, 52.0);
    
    
    CGFloat nextKeyboardButtonWidth = LINEAR_EQ(keyboardWidth,
                                                kPhoneKeyboardPortraitWidth, 34.0,
                                                kPhoneKeyboardLandscapeWidth, 50.0);
    
    CGFloat returnButtonWidth = LINEAR_EQ(keyboardWidth,
                                          kPhoneKeyboardPortraitWidth, 74.0,
                                          kPhoneKeyboardLandscapeWidth, 107.0);
    
    CGFloat deleteButtonWidth = LINEAR_EQ(keyboardWidth,
                                          kPhoneKeyboardPortraitWidth, 36.0,
                                          kPhoneKeyboardLandscapeWidth, 69.0);
    
    PhoneKeyboardMetrics metrics = {
        
        .nextKeyboardButtonFrame = {
            edgeMargin,
            keyboardHeight - bottomMargin - keyHeight,
            nextKeyboardButtonWidth,
            keyHeight
        },
        
        .returnButtonFrame = {
            keyboardWidth - edgeMargin - returnButtonWidth,
            keyboardHeight - bottomMargin - keyHeight,
            returnButtonWidth,
            keyHeight
        },
        
        .spaceButtonFrame = {
            edgeMargin + nextKeyboardButtonWidth + columnMargin,
            keyboardHeight - bottomMargin - keyHeight,
            keyboardWidth - (edgeMargin + nextKeyboardButtonWidth + columnMargin + columnMargin + returnButtonWidth + edgeMargin),
            keyHeight
        },
        
        .deleteButtonFrame = {
            keyboardWidth - edgeMargin - deleteButtonWidth,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight),
            deleteButtonWidth,
            keyHeight
        },
        
        .leftShiftButtonFrame = {
            edgeMargin,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight),
            LINEAR_EQ(keyboardWidth,
                      kPhoneKeyboardPortraitWidth, 36.0,
                      kPhoneKeyboardLandscapeWidth, 68.0),
            keyHeight
        },
        
        .yoButton = {
            (keyboardWidth - letterKeyWidth)/2,
            keyboardHeight - (bottomMargin + keyHeight + rowMargin + keyHeight + rowMargin + keyHeight),
            letterKeyWidth,
            keyHeight
        },
        
        .cornerRadius = ([[[UIDevice currentDevice] machine] hasPrefix:@"iPhone7,1"] ? 5.0 : 4.0),
        
    };
    return metrics;
}