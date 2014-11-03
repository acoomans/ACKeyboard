//
//  SettingsValuesTableViewController.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 11/1/14.
//
//

#import "SettingsValuesTableViewController.h"

static NSString *kSettingsValuesTableViewControllerCellIdentifier = @"kSettingsValuesTableViewControllerCellIdentifier";


@implementation SettingsValuesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kSettingsValuesTableViewControllerCellIdentifier];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingsValuesTableViewControllerCellIdentifier
                                                            forIndexPath:indexPath];
    if (self.titles || [self.titles count] < indexPath.row) {
        cell.textLabel.text = self.titles[indexPath.row];
    } else {
        cell.textLabel.text = self.values[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(settingsValuesTableViewController:didSelectValue:withTitle:atIndex:)]) {
        [self.delegate settingsValuesTableViewController:self
                                          didSelectValue:self.values[indexPath.row]
                                               withTitle:(self.titles[indexPath.row]?:nil)
                                                 atIndex:indexPath.row];
    }
}

@end
