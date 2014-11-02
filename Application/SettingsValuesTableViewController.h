//
//  SettingsValuesTableViewController.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#import <UIKit/UIKit.h>

@class SettingsValuesTableViewController;

@protocol SettingsValuesTableViewControllerDelegate <NSObject>
@optional
- (void)settingsValuesTableViewController:(SettingsValuesTableViewController*)settingsValuesTableViewController
                           didSelectValue:(id)value
                                withTitle:(NSString*)title
                                  atIndex:(NSInteger)index;
@end


@interface SettingsValuesTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, weak) id<SettingsValuesTableViewControllerDelegate> delegate;
@end
