//
//  ACKeyboardViewController.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/16/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "KeyboardViewController.h"

#import "Metrics.h"
#import "ACKey.h"
#import "ACLockKey.h"


static NSTimeInterval kDeleteTimerInterval = 0.1;

@interface KeyboardViewController ()

@property (nonatomic, strong) NSMutableArray *constraints;

@property (nonatomic, strong) ACKey *nextKeyboardButton;
@property (nonatomic, strong) ACKey *spaceButton;
@property (nonatomic, strong) ACKey *returnButton;
@property (nonatomic, strong) ACKey *yoButton;
@property (nonatomic, strong) ACKey *deleteButton;
@property (nonatomic, strong) ACLockKey *leftShiftButton;
@property (nonatomic, strong) ACLockKey *rightShiftButton;

@property (nonatomic, strong) NSRegularExpression *endOfSentenceRegularExpression;
@property (nonatomic, strong) NSRegularExpression *beginningOfSentenceRegularExpression;
@property (nonatomic, strong) NSRegularExpression *beginningOfWordRegularExpression;

@property (nonatomic, strong) NSTimer *deleteTimer;
@end


@implementation KeyboardViewController

#pragma mark - View

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateFont];
    
    // animating somehow reduces some jerkiness
    [UIView animateWithDuration:0.0 delay:0.0 options:0 animations:^{
        [self layoutViewForSize:self.view.frame.size];
    } completion:^(BOOL finished) {}];
}

- (void)layoutViewForSize:(CGSize)size {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        PadKeyboardMetrics padKeyboardMetrics = getPadLinearKeyboardMetrics(size.width, size.height);

        self.deleteButton.frame = padKeyboardMetrics.deleteButtonFrame;
        self.deleteButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        
        self.yoButton.frame = padKeyboardMetrics.yoButton;
        self.yoButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        self.returnButton.frame = padKeyboardMetrics.returnButtonFrame;
        self.returnButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        
        self.leftShiftButton.frame = padKeyboardMetrics.leftShiftButtonFrame;
        self.leftShiftButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        self.rightShiftButton.frame = padKeyboardMetrics.rightShiftButtonFrame;
        self.rightShiftButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        
        self.nextKeyboardButton.frame = padKeyboardMetrics.nextKeyboardButtonFrame;
        self.nextKeyboardButton.cornerRadius = padKeyboardMetrics.cornerRadius;
        self.spaceButton.frame = padKeyboardMetrics.spaceButtonFrame;
        self.spaceButton.cornerRadius = padKeyboardMetrics.cornerRadius;
    
    } else { // UIUserInterfaceIdiomPhone
        
        PhoneKeyboardMetrics phoneKeyboardMetrics = getPhoneLinearKeyboardMetrics(size.width, size.height);

        self.yoButton.frame = phoneKeyboardMetrics.yoButton;
        self.yoButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
        
        self.leftShiftButton.frame = phoneKeyboardMetrics.leftShiftButtonFrame;
        self.leftShiftButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
        self.deleteButton.frame = phoneKeyboardMetrics.deleteButtonFrame;
        self.deleteButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
        
        self.nextKeyboardButton.frame = phoneKeyboardMetrics.nextKeyboardButtonFrame;
        self.nextKeyboardButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
        self.spaceButton.frame = phoneKeyboardMetrics.spaceButtonFrame;
        self.spaceButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
        self.returnButton.frame = phoneKeyboardMetrics.returnButtonFrame;
        self.returnButton.cornerRadius = phoneKeyboardMetrics.cornerRadius;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Keys

- (ACKey*)nextKeyboardButton {
    if (!_nextKeyboardButton) {
        _nextKeyboardButton = [ACKey keyWithStyle:KeyStyleDark appearance:self.keyAppearance image:[UIImage imageNamed:@"global_portrait"]];
        [_nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nextKeyboardButton];
    }
    return _nextKeyboardButton;
}

- (ACKey*)returnButton {
    if (!_returnButton) {
        _returnButton = [ACKey keyWithStyle:KeyStyleDark appearance:self.keyAppearance title:@"return"];
        [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_returnButton];
    }
    return _returnButton;
}

- (ACKey*)spaceButton {
    if (!_spaceButton) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _spaceButton = [ACKey keyWithStyle:KeyStyleLight appearance:self.keyAppearance];
        } else {
            _spaceButton = [ACKey keyWithStyle:KeyStyleLight appearance:self.keyAppearance title:@"space"];
        }
        [_spaceButton addTarget:self action:@selector(spaceButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_spaceButton];
    }
    return _spaceButton;
}

- (ACKey*)yoButton {
    if (!_yoButton) {
        _yoButton = [ACKey keyWithStyle:KeyStyleLight appearance:self.keyAppearance title:@"YO"];
        [_yoButton addTarget:self action:@selector(yoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_yoButton];
    }
    return _yoButton;
}

- (ACKey*)deleteButton {
    if (!_deleteButton) {
        UIImage *image = [[UIImage imageNamed:@"delete_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _deleteButton = [ACKey keyWithStyle:KeyStyleDark appearance:self.keyAppearance image:image];
        [_deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpOutside];
        [self.view addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (ACLockKey*)leftShiftButton {
    if (!_leftShiftButton) {
        _leftShiftButton = [ACLockKey keyWithStyle:KeyStyleDark appearance:self.keyAppearance];
        _leftShiftButton.image = [[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _leftShiftButton.lockImage = [[UIImage imageNamed:@"shift_lock_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_leftShiftButton addTarget:self action:@selector(shiftButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_leftShiftButton addTarget:self action:@selector(shiftButtonDoubleTapped:) forControlEvents:UIControlEventTouchDownRepeat];
        [self.view addSubview:_leftShiftButton];
    }
    return _leftShiftButton;
}

- (ACLockKey*)rightShiftButton {
    if (!_rightShiftButton) {
        _rightShiftButton = [ACLockKey keyWithStyle:KeyStyleDark appearance:self.keyAppearance];
        _rightShiftButton.image = [[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _rightShiftButton.lockImage = [[UIImage imageNamed:@"shift_lock_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_rightShiftButton addTarget:self action:@selector(shiftButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_rightShiftButton addTarget:self action:@selector(shiftButtonDoubleTapped:) forControlEvents:UIControlEventTouchDownRepeat];
        [self.view addSubview:_rightShiftButton];
    }
    return _rightShiftButton;
}


#pragma mark - Regular expressions

- (NSRegularExpression*)endOfSentenceRegularExpression {
    if (!_endOfSentenceRegularExpression) {
        NSError* error = nil;
        _endOfSentenceRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-z0-9] \\z"
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:&error];
        
        if (!_endOfSentenceRegularExpression) {
            NSLog(@"cannot create regular expression: %@", [error description]);
        }
    }
    return _endOfSentenceRegularExpression;
}

- (NSRegularExpression*)beginningOfSentenceRegularExpression {
    if (!_beginningOfSentenceRegularExpression) {
        NSError* error = nil;
        _beginningOfSentenceRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"!\\s+\\z"
                                                                                          options:0
                                                                                            error:&error];
        
        if (!_beginningOfSentenceRegularExpression) {
            NSLog(@"cannot create regular expression: %@", [error description]);
        }
    }
    return _beginningOfSentenceRegularExpression;
}

- (NSRegularExpression*)beginningOfWordRegularExpression {
    if (!_beginningOfWordRegularExpression) {
        NSError* error = nil;
        _beginningOfWordRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\s+\\z"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:&error];
        
        if (!_beginningOfWordRegularExpression) {
            NSLog(@"cannot create regular expression: %@", [error description]);
        }
    }
    return _beginningOfWordRegularExpression;
}


#pragma mark - UITextInputDelegate

- (void)textWillChange:(id<UITextInput>)textInput {
    
}

- (void)textDidChange:(id<UITextInput>)textInput {
    [self updateReturnButtonStyle];
    [self updateReturnButtonEnabled];
    [self updateShiftButtonState];
    [self updateFont];
    [self updateAppearance];
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
    
}

- (KeyAppearance)keyAppearance {
    switch (self.textDocumentProxy.keyboardAppearance) {
        case UIKeyboardAppearanceDark:
            return KeyAppearanceDark;
        case UIKeyboardAppearanceLight:
        case UIKeyboardAppearanceDefault:
        default:
            return KeyAppearanceLight;
    }
}


#pragma mark - Keys state

- (void)updateReturnButtonStyle {
    
    switch (self.textDocumentProxy.returnKeyType) {
        case UIReturnKeyDefault:
        case UIReturnKeyDone:
            self.returnButton.title = @"return";
            break;
        case UIReturnKeyEmergencyCall:
            self.returnButton.title = @"Emergency Call";
            break;
        case UIReturnKeyGo:
            self.returnButton.title = @"Go";
            break;
        case UIReturnKeySearch:
        case UIReturnKeyGoogle:
        case UIReturnKeyYahoo:
            self.returnButton.title = @"Search";
            break;
        case UIReturnKeyJoin:
            self.returnButton.title = @"Join";
            break;
        case UIReturnKeyNext:
            self.returnButton.title = @"Next";
            break;
        case UIReturnKeyRoute:
            self.returnButton.title = @"Route";
            break;
        case UIReturnKeySend:
            self.returnButton.title = @"Send";
            break;
        default:;
    }
    
    switch (self.textDocumentProxy.returnKeyType) {
        case UIReturnKeyDefault:
        case UIReturnKeyNext:
            self.returnButton.style = KeyStyleDark;
            break;
        default:
            self.returnButton.style = KeyStyleBlue;
            break;
    }
}

- (void)updateReturnButtonEnabled {
    if (self.textDocumentProxy.enablesReturnKeyAutomatically &&
        self.textDocumentProxy.documentContextBeforeInput.length == 0 &&
        self.textDocumentProxy.documentContextAfterInput.length == 0) {
        
        self.returnButton.enabled = NO;
    } else {
        self.returnButton.enabled = YES;
    }
}

- (void)updateShiftButtonState {
    if (self.leftShiftButton.isLocked) {
        return;
    }
    
    BOOL selected = NO;
    
    NSString *beforeInput = self.textDocumentProxy.documentContextBeforeInput;
    
    switch (self.textDocumentProxy.autocapitalizationType) {
            
        case UITextAutocapitalizationTypeAllCharacters: {
            selected = YES;
            break;
        }
            
        case UITextAutocapitalizationTypeSentences: {
            if (beforeInput.length == 0 ||
                [[self.beginningOfSentenceRegularExpression matchesInString:beforeInput
                                                                    options:0
                                                                      range:NSMakeRange(0, beforeInput.length)] count]) {
                selected = YES;
            }
            break;
        }
            
        case UITextAutocapitalizationTypeWords: {
            if (beforeInput.length == 0 ||
                [[self.beginningOfWordRegularExpression matchesInString:beforeInput
                                                                options:0
                                                                  range:NSMakeRange(0, beforeInput.length)] count]) {
                selected = YES;
            }
            break;
        }
            
        case UITextAutocapitalizationTypeNone:
        default:
            break;
    }
    
    self.leftShiftButton.selected = _rightShiftButton.selected = selected;
}

- (void)updateFont {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        for (ACKey *key in @[self.returnButton, self.yoButton]) {
            if ([key isKindOfClass:[ACKey class]]) {
                if (self.view.frame.size.width >= 1024) {
                    key.titleFont = [UIFont systemFontOfSize:kKeyPadLandscapeTitleFontSize];
                } else {
                    key.titleFont = [UIFont systemFontOfSize:kKeyPadPortraitTitleFontSize];
                }
            }
        }
    }
}

- (void)updateAppearance {
    for (ACKey *key in self.view.subviews) {
        if ([key isKindOfClass:[ACKey class]]) {
            key.appearance = self.keyAppearance;
        }
    }
}


#pragma mark - Text actions

- (void)deleteBackward {
    
    NSString *beforeInput = self.textDocumentProxy.documentContextBeforeInput;
    
    if (beforeInput.length > 1) {
        NSString *coupleOfLastCharacters = [beforeInput substringWithRange:NSMakeRange(beforeInput.length-2, 2)];
        if( [@"yo" caseInsensitiveCompare:coupleOfLastCharacters] == NSOrderedSame ) {
            [self.textDocumentProxy deleteBackward];
        }
    }
    [self.textDocumentProxy deleteBackward];
    [self updateReturnButtonEnabled];
    [self updateShiftButtonState];
}

- (void)insertText:(NSString*)text {
    [self.textDocumentProxy insertText:text];
    [self updateReturnButtonEnabled];
    [self updateShiftButtonState];
}


#pragma mark - Keys actions

- (IBAction)returnButtonTapped:(id)sender {
    [self insertText:@"\n"];
}

- (IBAction)spaceButtonTapped:(id)sender {
    
    NSString *beforeInput = self.textDocumentProxy.documentContextBeforeInput;
    if (beforeInput.length &&
        ([[self.endOfSentenceRegularExpression matchesInString:beforeInput
                                                     options:0
                                                       range:NSMakeRange(0, beforeInput.length)] count] > 0)
        ) {
        [self.textDocumentProxy deleteBackward];
        [self insertText:@"! "];
    } else {
        [self insertText:@" "];
    }
}

- (IBAction)yoButtonTapped:(id)sender {
    if (self.leftShiftButton.isLocked || self.leftShiftButton.selected) {
        [self insertText:@"YO"];
    } else {
        [self insertText:@"yo"];
    }
}

- (IBAction)deleteButtonTapped:(id)sender {
    [self deleteBackward];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:kDeleteTimerInterval
                                                      target:self
                                                    selector:@selector(deleteTimerFireMethod:)
                                                    userInfo:nil
                                                     repeats:YES];
    self.deleteTimer = timer;
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        if (timer == self.deleteTimer) {
            [weakSelf.deleteTimer fire];
        }
    });
}

- (void)deleteTimerFireMethod:(NSTimer *)timer {
    if (self.deleteButton.highlighted) {
        [self deleteBackward];
    } else {
        [timer invalidate];
        self.deleteTimer = nil;
    }
}

- (IBAction)deleteButtonReleased:(id)sender {
    [self.deleteTimer invalidate];
    self.deleteTimer = nil;
}

- (void)shiftButtonTapped:(id)sender {
    if (self.leftShiftButton.isLocked) {
        self.leftShiftButton.selected = _rightShiftButton.selected = NO;
        self.leftShiftButton.locked = _rightShiftButton.locked = NO;
    } else {
        self.leftShiftButton.selected = _rightShiftButton.selected = ! self.leftShiftButton.selected;
    }
}

- (void)shiftButtonDoubleTapped:(id)sender {
    self.leftShiftButton.selected = _rightShiftButton.selected = YES;
    self.leftShiftButton.locked = _rightShiftButton.locked = ! self.leftShiftButton.isLocked;
}

@end
