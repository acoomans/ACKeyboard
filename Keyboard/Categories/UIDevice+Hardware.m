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
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *result = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return result;
}

@end
