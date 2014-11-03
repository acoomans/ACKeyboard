//
//  UIDevice+Hardware.m
//  ACKeyboard
//
//  Created by Arnaud Coomans on 8/23/14.
//
//

#import "UIDevice+Hardware.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

- (NSString *)machine {
    
    static NSString *_machine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#if TARGET_IPHONE_SIMULATOR
        
        // hack for core simulator, device plist is ~/Library/Developer/CoreSimulator/Devices/DEVICE-UUID/device.plist
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [paths firstObject];
        NSString *devicePlist = [NSString pathWithComponents:[[libraryDirectory pathComponents] arrayByAddingObjectsFromArray:@[@"..", @"..", @"device.plist"]]];
        NSDictionary *deviceDescription = [NSDictionary dictionaryWithContentsOfFile:devicePlist];
        NSString *deviceType = deviceDescription[@"deviceType"];
        
        if ([deviceType hasSuffix:@"iPhone-4s"]) {
            _machine = @"iPhone4,";
        } else if ([deviceType hasSuffix:@"iPhone-5"]) {
            _machine = @"iPhone5,";
        } else if ([deviceType hasSuffix:@"iPhone-5s"]) {
            _machine = @"iPhone6,";
        } else if ([deviceType hasSuffix:@"iPhone-6"]) {
            _machine = @"iPhone7,2";
        } else if ([deviceType hasSuffix:@"iPhone-6-Plus"]) {
            _machine = @"iPhone7,1";
        } else if ([deviceType hasSuffix:@"iPad-2"]) {
            _machine = @"iPad2,";
        } else if ([deviceType hasSuffix:@"iPad-Retina"]) {
            _machine = @"iPad3,";
        } else if ([deviceType hasSuffix:@"iPad-Air"]) {
            _machine = @"iPad4,";
        } else {
            NSAssert(NO, @"Unknown simulator model");
        }
#else
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        _machine = [NSString stringWithUTF8String:machine];
        free(machine);
#endif
    });
    
    return _machine;
}

@end
