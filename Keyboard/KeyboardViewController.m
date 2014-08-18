//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by Arnaud Coomans on 8/16/14.
//  Copyright (c) 2014 Arnaud Coomans. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Key.h"
#import "LockKey.h"


static CGFloat kKeysEdgeMargin = 2.5;
static CGFloat kKeysBottomMargin = 3.0;
static CGFloat kKeysRowMargin = 15.0;
static NSTimeInterval kDeleteTimerInterval = 0.1;


@interface KeyboardViewController ()

@property (nonatomic, strong) Key *nextKeyboardButton;
@property (nonatomic, strong) Key *spaceButton;
@property (nonatomic, strong) Key *returnButton;
@property (nonatomic, strong) Key *yoButton;
@property (nonatomic, strong) Key *deleteButton;
@property (nonatomic, strong) LockKey *shiftButton;

@property (nonatomic, strong) NSRegularExpression *endOfSentenceRegularExpression;
@property (nonatomic, strong) NSRegularExpression *beginningOfSentenceRegularExpression;
@property (nonatomic, strong) NSRegularExpression *beginningOfWordRegularExpression;

@property (nonatomic, strong) NSTimer *deleteTimer;
@end


@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    //    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.view
    //                                                                        attribute:NSLayoutAttributeHeight
    //                                                                        relatedBy:NSLayoutRelationEqual
    //                                                                           toItem:nil
    //                                                                        attribute:NSLayoutAttributeNotAnAttribute
    //                                                                       multiplier:0.0
    //                                                                         constant:100.0]; //DEBUG not working as of xcode6-beta5
    //    [self.view addConstraints:@[heightConstraint]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNextKeyboardButton];
    [self addReturnButton];
    [self addSpaceButton];
    [self addYoButton];
    [self addDeleteButton];
    [self addShiftButton];
}


- (void)addNextKeyboardButton {
    self.nextKeyboardButton = [Key keyWithStyle:KeyStyleDark image:[UIImage imageNamed:@"global_portrait"]];
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextKeyboardButton];
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton
                                                                                            attribute:NSLayoutAttributeLeft
                                                                                            relatedBy:NSLayoutRelationEqual
                                                                                               toItem:self.view
                                                                                            attribute:NSLayoutAttributeLeft
                                                                                           multiplier:1.0
                                                                                             constant:kKeysEdgeMargin];
    
    NSLayoutConstraint *nextKeyboardButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton
                                                                                         attribute:NSLayoutAttributeWidth
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:nil
                                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                                        multiplier:1.0
                                                                                          constant:35.0];
    
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton
                                                                                          attribute:NSLayoutAttributeBottom
                                                                                          relatedBy:NSLayoutRelationEqual
                                                                                             toItem:self.view
                                                                                          attribute:NSLayoutAttributeBottom
                                                                                         multiplier:1.0
                                                                                           constant:-kKeysBottomMargin];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint,
                                nextKeyboardButtonWidthConstraint,
                                nextKeyboardButtonBottomConstraint,
                                ]];
}

- (void)addReturnButton {
    self.returnButton = [Key keyWithStyle:KeyStyleDark title:@"return"];
    [self.returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnButton];
    
    NSLayoutConstraint *returnButtonRightSideConstraint = [NSLayoutConstraint constraintWithItem:self.returnButton
                                                                                       attribute:NSLayoutAttributeRight
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.view
                                                                                       attribute:NSLayoutAttributeRight
                                                                                      multiplier:1.0
                                                                                        constant:-kKeysEdgeMargin];
    
    NSLayoutConstraint *returnButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.returnButton
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0
                                                                                    constant:75.0];
    
    NSLayoutConstraint *returnButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.returnButton
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0
                                                                                     constant:-kKeysBottomMargin];
    [self.view addConstraints:@[returnButtonWidthConstraint,
                                returnButtonRightSideConstraint,
                                returnButtonBottomConstraint,
                                ]];
}

- (void)addSpaceButton {
    self.spaceButton = [Key keyWithStyle:KeyStyleLight title:@"space"];
    [self.spaceButton addTarget:self action:@selector(spaceButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.spaceButton];
    
    NSLayoutConstraint *spaceButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton
                                                                                     attribute:NSLayoutAttributeRight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.spaceButton
                                                                                     attribute:NSLayoutAttributeLeft
                                                                                    multiplier:1.0
                                                                                      constant:2*-kKeysEdgeMargin];
    
    NSLayoutConstraint *spaceButtonRightSideConstraint = [NSLayoutConstraint constraintWithItem:self.spaceButton
                                                                                      attribute:NSLayoutAttributeRight
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:self.returnButton
                                                                                      attribute:NSLayoutAttributeLeft
                                                                                     multiplier:1.0
                                                                                       constant:2*-kKeysEdgeMargin];
    
    NSLayoutConstraint *spaceButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.spaceButton
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.view
                                                                                   attribute:NSLayoutAttributeBottom
                                                                                  multiplier:1.0
                                                                                    constant:-kKeysBottomMargin];
    [self.view addConstraints:@[spaceButtonLeftSideConstraint,
                                spaceButtonRightSideConstraint,
                                spaceButtonBottomConstraint,
                                ]];
}

- (void)addYoButton {
    self.yoButton = [Key keyWithStyle:KeyStyleLight title:@"yo"];
    [self.yoButton addTarget:self action:@selector(yoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.yoButton];
    
    NSLayoutConstraint *yoButtonHorizontalConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                   multiplier:1.0
                                                                                     constant:0.0];
    
    NSLayoutConstraint *yoButtonVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeCenterY
                                                                                 multiplier:1.0
                                                                                   constant:-22.0];
    
    NSLayoutConstraint *yoButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0
                                                                                constant:70.0];
    
    [self.view addConstraints:@[yoButtonHorizontalConstraint,
                                yoButtonVerticalConstraint,
                                yoButtonWidthConstraint,
                                ]];
}

- (void)addDeleteButton {
    UIImage *image = [UIImage imageNamed:@"delete_portrait"];
    UIImage *highlightedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.deleteButton = [Key keyWithStyle:KeyStyleDark image:image];
    [self.deleteButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchDown];
    [self.deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:self.deleteButton];
    
    NSLayoutConstraint *deleteButtonRightSideConstraint = [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                                                       attribute:NSLayoutAttributeRight
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.view
                                                                                       attribute:NSLayoutAttributeRight
                                                                                      multiplier:1.0
                                                                                        constant:-kKeysEdgeMargin];
    
    NSLayoutConstraint *deleteButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0
                                                                                    constant:37.0];
    
    NSLayoutConstraint *deleteButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.deleteButton
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.returnButton
                                                                                    attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0
                                                                                     constant:-kKeysRowMargin];
    [self.view addConstraints:@[deleteButtonRightSideConstraint,
                                deleteButtonWidthConstraint,
                                deleteButtonBottomConstraint,
                                ]];
}

- (void)addShiftButton {

    self.shiftButton = [LockKey keyWithStyle:KeyStyleDark];
    
    self.shiftButton.unlockImage = [UIImage imageNamed:@"shift_portrait"];
    self.shiftButton.unlockSelectedImage = [self.shiftButton.unlockImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.shiftButton.lockImage = [UIImage imageNamed:@"shift_lock_portrait"];
    self.shiftButton.lockSelectedImage = [self.shiftButton.lockImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.shiftButton addTarget:self action:@selector(shiftButtonTapped:) forControlEvents:UIControlEventTouchDown];
    [self.shiftButton addTarget:self action:@selector(shiftButtonDoubleTapped:) forControlEvents:UIControlEventTouchDownRepeat];
    [self.view addSubview:self.shiftButton];
    
    NSLayoutConstraint *shiftButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.shiftButton
                                                                                       attribute:NSLayoutAttributeLeft
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.view
                                                                                       attribute:NSLayoutAttributeLeft
                                                                                      multiplier:1.0
                                                                                        constant:kKeysEdgeMargin];
    
    NSLayoutConstraint *shiftButtonWidthConstraint = [NSLayoutConstraint constraintWithItem:self.shiftButton
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0
                                                                                    constant:37.0];
    
    NSLayoutConstraint *shiftButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.shiftButton
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.nextKeyboardButton
                                                                                    attribute:NSLayoutAttributeTop
                                                                                   multiplier:1.0
                                                                                     constant:-kKeysRowMargin];
    [self.view addConstraints:@[shiftButtonLeftSideConstraint,
                                shiftButtonWidthConstraint,
                                shiftButtonBottomConstraint,
                                ]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //DEBUG
    //    CGRect frame = self.view.frame;
    //    frame.size.height = 50;
    //    frame.origin.y = 100;
    //    self.view.frame = frame;
    
    //DEBUG
    //    self.view.backgroundColor = [UIColor blueColor];
    //    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - properties

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
    
//    UIColor *textColor = nil;
//    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
//        textColor = [UIColor whiteColor];
//    } else {
//        textColor = [UIColor blackColor];
//    }
//    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
    
}

#pragma mark - Keys style

- (void)updateReturnButtonStyle {
    
    switch (self.textDocumentProxy.returnKeyType) {
        case UIReturnKeyDefault:
            [self.returnButton setTitle:@"return" forState:UIControlStateNormal];
            break;
        case UIReturnKeyDone:
            [self.returnButton setTitle:@"Done" forState:UIControlStateNormal];
            break;
        case UIReturnKeyEmergencyCall:
            [self.returnButton setTitle:@"Emergency Call" forState:UIControlStateNormal];
            break;
        case UIReturnKeyGo:
            [self.returnButton setTitle:@"Go" forState:UIControlStateNormal];
            break;
        case UIReturnKeyGoogle:
            [self.returnButton setTitle:@"Search" forState:UIControlStateNormal];
            break;
        case UIReturnKeyJoin:
            [self.returnButton setTitle:@"Join" forState:UIControlStateNormal];
            break;
        case UIReturnKeyNext:
            [self.returnButton setTitle:@"Next" forState:UIControlStateNormal];
            break;
        case UIReturnKeyRoute:
            [self.returnButton setTitle:@"Route" forState:UIControlStateNormal];
            break;
        case UIReturnKeySearch:
            [self.returnButton setTitle:@"Search" forState:UIControlStateNormal];
            break;
        case UIReturnKeySend:
            [self.returnButton setTitle:@"Send" forState:UIControlStateNormal];
            break;
        case UIReturnKeyYahoo:
            [self.returnButton setTitle:@"Search" forState:UIControlStateNormal];
            break;
        default:;
    }
    
    switch (self.textDocumentProxy.returnKeyType) {            
        case UIReturnKeyDefault:
        case UIReturnKeyNext:
            [self.returnButton setKeyStyle:KeyStyleDark];
            break;
        default:
            [self.returnButton setKeyStyle:KeyStyleBlue];
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
    if (self.shiftButton.isLocked) {
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

    self.shiftButton.selected = selected;
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
    
    NSArray *matches = [self.endOfSentenceRegularExpression matchesInString:beforeInput
                                                                    options:0
                                                                      range:NSMakeRange(0, beforeInput.length)];
    if ([matches count] > 0) {
        [self.textDocumentProxy deleteBackward];
        [self insertText:@"! "];
    } else {
        [self insertText:@" "];
    }
}

- (IBAction)yoButtonTapped:(id)sender {
    if (self.shiftButton.isLocked || self.shiftButton.selected) {
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
    if (self.shiftButton.isLocked) {
        self.shiftButton.selected = NO;
        self.shiftButton.locked = NO;
    } else {
        self.shiftButton.selected = ! self.shiftButton.selected;
    }
}

- (void)shiftButtonDoubleTapped:(id)sender {
    self.shiftButton.selected = YES;
    self.shiftButton.locked = ! self.shiftButton.isLocked;
}

@end
