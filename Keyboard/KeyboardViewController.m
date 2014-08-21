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


static CGFloat kKeysEdgeMargin = 3.0;
static CGFloat kKeysColumnMargin = 6.0;
static CGFloat kKeysBottomMargin = 3.0;
static CGFloat kKeysRowMargin = 15.0;

static NSTimeInterval kDeleteTimerInterval = 0.1;


@interface KeyboardViewController ()

@property (nonatomic, strong) NSMutableArray *constraints;

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

#pragma mark - View

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [self.view removeConstraints:self.constraints];
    
    NSDictionary *metrics = @{
                              @"edge": @(kKeysEdgeMargin),
                              @"cmargin": @(kKeysColumnMargin),
                              @"rmargin": @(kKeysRowMargin),
                              @"bottom": @(kKeysBottomMargin),
                              };
    NSDictionary *views = @{
                            @"next": self.nextKeyboardButton,
                            @"space": self.spaceButton,
                            @"return": self.returnButton,
                            @"delete": self.deleteButton,
                            @"yo": self.yoButton,
                            @"shift": self.shiftButton,
                            };
    
    self.constraints = [[NSMutableArray alloc] init];

    
    [self.constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:[yo(==58.0)]-115.0-|"
                                           options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
                                           metrics:metrics
                                           views:views]];
    [self.constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|-edge-[shift(==36.0)]-(>=0.0)-[delete(==36.0)]-edge-|"
                                           options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
                                           metrics:metrics
                                           views:views]];
    [self.constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|-edge-[next(<=34.0)]-cmargin-[space]-cmargin-[return(<=74.0)]-edge-|"
                                           options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
                                           metrics:metrics
                                           views:views]];
    [self.constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:[yo(==39.0)]-rmargin-[delete(==39.0)]-rmargin-[next(==39.0)]-bottom-|"
                                           options:0
                                           metrics:metrics
                                           views:views]];
    
    [self.view addConstraints:self.constraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setNeedsUpdateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Keys

- (Key*)nextKeyboardButton {
    if (!_nextKeyboardButton) {
        _nextKeyboardButton = [Key keyWithStyle:KeyStyleDark image:[UIImage imageNamed:@"global_portrait"]];
        _nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nextKeyboardButton];
    }
    return _nextKeyboardButton;
}

- (Key*)returnButton {
    if (!_returnButton) {
        _returnButton = [Key keyWithStyle:KeyStyleDark title:@"return"];
        _returnButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_returnButton];
    }
    return _returnButton;
}

- (Key*)spaceButton {
    if (!_spaceButton) {
        _spaceButton = [Key keyWithStyle:KeyStyleLight title:@"space"];
        _spaceButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_spaceButton addTarget:self action:@selector(spaceButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_spaceButton];
    }
    return _spaceButton;
}

- (Key*)yoButton {
    if (!_yoButton) {
        _yoButton = [Key keyWithStyle:KeyStyleLight title:@"YO"];
        _yoButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_yoButton addTarget:self action:@selector(yoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_yoButton];
    }
    return _yoButton;
}

- (Key*)deleteButton {
    if (!_deleteButton) {
        UIImage *image = [[UIImage imageNamed:@"delete_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _deleteButton = [Key keyWithStyle:KeyStyleDark image:image];
        _deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton addTarget:self action:@selector(deleteButtonReleased:) forControlEvents:UIControlEventTouchUpOutside];
        [self.view addSubview:_deleteButton];
    }
    return _deleteButton;
}

- (LockKey*)shiftButton {
    if (!_shiftButton) {
        
        _shiftButton = [LockKey keyWithStyle:KeyStyleDark];
        _shiftButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        _shiftButton.image = [[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _shiftButton.lockImage = [[UIImage imageNamed:@"shift_lock_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
        [_shiftButton addTarget:self action:@selector(shiftButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [_shiftButton addTarget:self action:@selector(shiftButtonDoubleTapped:) forControlEvents:UIControlEventTouchDownRepeat];
        [self.view addSubview:_shiftButton];
    }
    return _shiftButton;
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
            self.returnButton.keyStyle = KeyStyleDark;
            break;
        default:
            self.returnButton.keyStyle = KeyStyleBlue;
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
    if (beforeInput.length &&
        ([self.endOfSentenceRegularExpression matchesInString:beforeInput
                                                     options:0
                                                       range:NSMakeRange(0, beforeInput.length)] > 0)
        ) {
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
