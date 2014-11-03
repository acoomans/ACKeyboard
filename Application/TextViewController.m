//
//  ViewController.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/16/14.
//
//

#import "TextViewController.h"

@interface TextViewController ()
@end


@implementation TextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    self.textView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[SettingsTableViewController class]]) {
        SettingsTableViewController *settingsTableViewController = segue.destinationViewController;
        settingsTableViewController.delegate = self;
    }
}


#pragma mark - SettingsTableViewControllerDelegate

- (id)currentValueForSettingsTableViewController:(SettingsTableViewController*)settingsTableViewController
                                         forType:(SettingsTableViewControllerType)settingType {
    switch (settingType) {
        case SettingsTableViewControllerTypeCapitalization:
            return @(self.textView.autocapitalizationType);
        case SettingsTableViewControllerTypeReturnKey:
            return @(self.textView.returnKeyType);
        case SettingsTableViewControllerTypeAppearance:
            return @(self.textView.keyboardAppearance);
        case SettingsTableViewControllerTypeAutoEnableReturnKey:
            return @(self.textView.enablesReturnKeyAutomatically);
        case SettingsTableViewControllerTypeBackgroundColor:
            return self.textView.backgroundColor;
        default:
            return nil;
    }
}

- (void)settingsTableViewController:(SettingsTableViewController*)settingsTableViewController
                     didSelectValue:(id)value
                            forType:(SettingsTableViewControllerType)settingType {
    switch (settingType) {
        case SettingsTableViewControllerTypeCapitalization:
            self.textView.autocapitalizationType = [value integerValue];
            break;
        case SettingsTableViewControllerTypeReturnKey:
            self.textView.returnKeyType = [value integerValue];
            break;
        case SettingsTableViewControllerTypeAppearance:
            self.textView.keyboardAppearance = [value integerValue];
            break;
        case SettingsTableViewControllerTypeAutoEnableReturnKey:
            self.textView.enablesReturnKeyAutomatically = [value boolValue];
            break;
        case SettingsTableViewControllerTypeBackgroundColor:
            self.textView.backgroundColor = self.view.backgroundColor = value;
        default:
            break;
    }
}

@end
