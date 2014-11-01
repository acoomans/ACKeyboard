//
//  SettingsTableViewController.h
//  Yoboard
//
//  Created by Arnaud Coomans on 10/12/14.
//
//

#import <UIKit/UIKit.h>
#import "SettingsValuesTableViewController.h"


typedef NS_ENUM(NSInteger, SettingsTableViewControllerType) {
    SettingsTableViewControllerTypeCapitalization,
    SettingsTableViewControllerTypeReturnKey,
    SettingsTableViewControllerTypeAppearance,
    SettingsTableViewControllerTypeAutoEnableReturnKey,
};


@class SettingsTableViewController;

@protocol SettingsTableViewControllerDelegate <NSObject>
@optional
- (id)currentValueForSettingsTableViewController:(SettingsTableViewController*)settingsTableViewController
                                         forType:(SettingsTableViewControllerType)settingType;
- (void)settingsTableViewController:(SettingsTableViewController*)settingsTableViewController
                     didSelectValue:(id)value
                            forType:(SettingsTableViewControllerType)settingType;
@end


@interface SettingsTableViewController : UITableViewController <SettingsValuesTableViewControllerDelegate>
@property (nonatomic, weak) id<SettingsTableViewControllerDelegate> delegate;
@end
