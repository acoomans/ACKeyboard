//
//  ViewController.h
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/16/14.
//
//

#import <UIKit/UIKit.h>
#import "SettingsTableViewController.h"

@interface TextViewController : UIViewController <SettingsTableViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UITextView *textView;
@end

