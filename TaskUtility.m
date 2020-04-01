//
//  TaskUtility.m
//  NameAndPassword
//
//  Created by Satendra Singh on 29/03/20.
//

#import "TaskUtility.h"

@implementation TaskUtility

+ (void)runbashScript:(NSString *)script {//without .sh
    NSArray * theArguments = [script componentsSeparatedByString:@" "];
//    [theArguments addObjectsFromArray:arguments];
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:theArguments] waitUntilExit];
}

@end
