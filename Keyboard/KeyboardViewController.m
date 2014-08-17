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
    [self addDeleteButton];
    [self addShiftButton];
    [self addYoButton];
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
    
    NSLayoutConstraint *spaceButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:self.spaceButton
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:self.nextKeyboardButton
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                  multiplier:1.0
                                                                                    constant:0.0];
    [self.view addConstraints:@[spaceButtonLeftSideConstraint,
                                spaceButtonRightSideConstraint,
                                spaceButtonBottomConstraint,
                                spaceButtonHeightConstraint,
                                ]];
}

- (void)addYoButton {
    self.yoButton = [Key keyWithStyle:KeyStyleLight title:@"yo"];
    [self.yoButton addTarget:self action:@selector(yoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.yoButton];
    
    NSLayoutConstraint *yoButtonTopConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1.0
                                                                               constant:12];
    
    NSLayoutConstraint *yoButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                                    attribute:NSLayoutAttributeLeft
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.shiftButton
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1.0
                                                                               constant:11.0];
    
    NSLayoutConstraint *yoButtonRightConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                              attribute:NSLayoutAttributeRight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.deleteButton
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:-11.0];
    
    NSLayoutConstraint *yoButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.yoButton
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.spaceButton
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:-kKeysRowMargin];
    
    [self.view addConstraints:@[yoButtonTopConstraint,
                                yoButtonLeftConstraint,
                                yoButtonRightConstraint,
                                yoButtonBottomConstraint,
                                ]];
}

- (void)addDeleteButton {
    UIImage *image = [UIImage imageNamed:@"delete_portrait"];
    UIImage *highlightedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.deleteButton = [Key keyWithStyle:KeyStyleDark image:image];
    [self.deleteButton setImage:highlightedImage forState:UIControlStateHighlighted];
    [self.deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchDown];
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

- (NSRegularExpression*)endOfSentenceRegularExpression {
    if (!_endOfSentenceRegularExpression) {
        NSError* error = nil;
        _endOfSentenceRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-z] \\z"
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:&error];
        
        if (!_endOfSentenceRegularExpression) {
            NSLog(@"cannot create regular expression: %@", [error description]);
        }
    }
    return _endOfSentenceRegularExpression;
}


#pragma mark - UITextInputDelegate

- (void)textWillChange:(id<UITextInput>)textInput {
    
}

- (void)textDidChange:(id<UITextInput>)textInput {
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
}


#pragma mark - Keys actions

- (IBAction)returnButtonTapped:(id)sender {
    [self.textDocumentProxy insertText:@"\n"];
}

- (IBAction)spaceButtonTapped:(id)sender {
    
    NSString *beforeInput = self.textDocumentProxy.documentContextBeforeInput;
    
    NSArray *matches = [self.endOfSentenceRegularExpression matchesInString:beforeInput
                                                                    options:0
                                                                      range:NSMakeRange(0, beforeInput.length)];
    if ([matches count] > 0) {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@". "];
    } else {
        [self.textDocumentProxy insertText:@" "];
    }
}

- (IBAction)yoButtonTapped:(id)sender {
    if (self.shiftButton.isLocked || self.shiftButton.selected) {
        [self.textDocumentProxy insertText:@"YO"];
    } else {
        [self.textDocumentProxy insertText:@"yo"];
    }
    
    if (!self.shiftButton.isLocked) {
        self.shiftButton.selected = NO;
    }

}

- (IBAction)deleteButtonTapped:(id)sender {
    [self.textDocumentProxy deleteBackward];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        weakSelf.deleteTimer = [NSTimer scheduledTimerWithTimeInterval:kDeleteTimerInterval
                                                   target:self
                                                 selector:@selector(deleteTimerFireMethod:)
                                                 userInfo:nil
                                                  repeats:YES];
        [weakSelf.deleteTimer fire];
    });
}

- (void)deleteTimerFireMethod:(NSTimer *)timer {
    if (self.deleteButton.highlighted) {
        [self.textDocumentProxy deleteBackward];
    } else {
        [timer invalidate];
        self.deleteTimer = nil;
    }
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
    self.shiftButton.locked = ! self.shiftButton.isLocked;
}

@end
