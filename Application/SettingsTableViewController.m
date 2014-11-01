//
//  SettingsTableViewController.m
//  Yoboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#import "SettingsTableViewController.h"
#import "UIView+Search.h"

static NSString *kSettingsTableViewControllerTextCellIdentifier = @"kSettingsTableViewControllerTextCellIdentifier";
static NSString *kSettingsTableViewControllerSwitchCellIdentifier = @"kSettingsTableViewControllerSwitchCellIdentifier";


@interface SettingsTableViewController ()
@property (nonatomic, strong) NSDictionary *textAutocapitalizationValues;
@property (nonatomic, strong) NSDictionary *returnKeyDefaultValues;
@property (nonatomic, strong) NSDictionary *keyboardAppearanceValues;
@property (nonatomic, strong) NSDictionary *autoEnableReturnKeyValues;
@end


@implementation SettingsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textAutocapitalizationValues = @{
                                          @(UITextAutocapitalizationTypeNone): @"None",
                                          @(UITextAutocapitalizationTypeWords): @"Words",
                                          @(UITextAutocapitalizationTypeSentences): @"Sentences",
                                          @(UITextAutocapitalizationTypeAllCharacters): @"All characters"
                                          };
    self.returnKeyDefaultValues = @{
                                    @(UIReturnKeyDefault): @"Default",
                                    @(UIReturnKeyGo): @"Blue",
                                    };
    self.keyboardAppearanceValues = @{
                                      @(UIKeyboardAppearanceDefault): @"Default",
                                      @(UIKeyboardAppearanceLight): @"Light",
                                      @(UIKeyboardAppearanceDark): @"Dark",
                                      };
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4; // number of SettingsTableViewControllerType
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case SettingsTableViewControllerTypeCapitalization:
        case SettingsTableViewControllerTypeReturnKey:
        case SettingsTableViewControllerTypeAppearance: {
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingsTableViewControllerTextCellIdentifier
                                                   forIndexPath:indexPath];
            break;
        }
        case SettingsTableViewControllerTypeAutoEnableReturnKey: {
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingsTableViewControllerSwitchCellIdentifier
                                                   forIndexPath:indexPath];
                        break;
        }
        default:
            break;
    }
    
    NSString *title = nil;
    id value = nil;
    if ([self.delegate respondsToSelector:@selector(currentValueForSettingsTableViewController:forType:)]) {
        value = [self.delegate currentValueForSettingsTableViewController:self forType:indexPath.row];
    }
    
    SEL switchAction = nil;
    
    switch (indexPath.row) {
        case SettingsTableViewControllerTypeCapitalization: {
            title = [NSString stringWithFormat:@"Capitalization: %@", self.textAutocapitalizationValues[value]];
            break;
        }
        case SettingsTableViewControllerTypeReturnKey: {
            title = [NSString stringWithFormat:@"Return Key: %@", self.returnKeyDefaultValues[value]];
            break;
        }
        case SettingsTableViewControllerTypeAppearance: {
            title = [NSString stringWithFormat:@"Appearance: %@", self.keyboardAppearanceValues[value]];
            break;
        }
        case SettingsTableViewControllerTypeAutoEnableReturnKey: {
            title = @"Auto-Enable Return Key";
            switchAction = @selector(autoEnableReturnKeySwitchTapped:);
            break;
        }
        default:
            break;
    }
    
    cell.textLabel.text = title;

    if (switchAction) {
        UISwitch *s = (UISwitch*)[cell firstRecursiveSubviewWithClass:[UISwitch class]];
        [s removeTarget:self action:nil forControlEvents:UIControlEventValueChanged];
        [s addTarget:self action:switchAction forControlEvents:UIControlEventValueChanged];
        s.on = [value boolValue];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *values = nil;
    
    switch (indexPath.row) {
        case SettingsTableViewControllerTypeCapitalization: {
            values = self.textAutocapitalizationValues;
            break;
        }
        case SettingsTableViewControllerTypeReturnKey: {
            values = self.returnKeyDefaultValues;
            break;
        }
        case SettingsTableViewControllerTypeAppearance: {
            values = self.keyboardAppearanceValues;
            break;
        }
        case SettingsTableViewControllerTypeAutoEnableReturnKey:
        default:
            break;
    }
    
    if (values) {
        SettingsValuesTableViewController *settingsValuesTableViewController = [[SettingsValuesTableViewController alloc] init];
        settingsValuesTableViewController.delegate = self;
        settingsValuesTableViewController.titles = [values allValues];
        settingsValuesTableViewController.values = [values allKeys];
        [self.navigationController pushViewController:settingsValuesTableViewController animated:YES];
    }
}


#pragma mark - SettingsValuesTableViewControllerDelegate

- (void)settingsValuesTableViewController:(SettingsValuesTableViewController*)settingsValuesTableViewController
                           didSelectValue:(id)value
                                withTitle:(NSString*)title
                                  atIndex:(NSInteger)index {
    switch ([self.tableView indexPathForSelectedRow].row) {
        case SettingsTableViewControllerTypeCapitalization:
        case SettingsTableViewControllerTypeReturnKey:
        case SettingsTableViewControllerTypeAppearance: {
            if ([self.delegate respondsToSelector:@selector(settingsTableViewController:didSelectValue:forType:)]) {
                [self.delegate settingsTableViewController:self
                                            didSelectValue:value
                                                   forType:[self.tableView indexPathForSelectedRow].row];
            }
            [self.tableView reloadData];
            [self.navigationController popViewControllerAnimated:YES];
        }
        case SettingsTableViewControllerTypeAutoEnableReturnKey:
        default:
            break;
    }
}

#pragma mark - Actions

- (IBAction)autoEnableReturnKeySwitchTapped:(UISwitch*)autoEnableReturnKeySwitch {
    if ([self.delegate respondsToSelector:@selector(settingsTableViewController:didSelectValue:forType:)]) {
        [self.delegate settingsTableViewController:self
                                    didSelectValue:@(autoEnableReturnKeySwitch.on)
                                           forType:SettingsTableViewControllerTypeAutoEnableReturnKey];
    }
}

@end
