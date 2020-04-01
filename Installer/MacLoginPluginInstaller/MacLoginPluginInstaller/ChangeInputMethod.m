//
//  ChangeInputMethod.m
//  Compact Identity Setup
//
//  Created by Satendra Singh on 31/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//

#import "ChangeInputMethod.h"

@implementation ChangeInputMethod

+(void)updatePluginNameInLogin{
    
    NSString *DIR_PATH = @"/Library/Application Support/compact/";
    NSError *error = nil;
    NSString *inputString = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@%@",DIR_PATH,@"system.login.console.original.txt"] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Read String Err:%@",error);
    error = nil;
    NSString *FIND = @"loginwindow:login";
    NSString *REPLACE = @"CompactIdentityLogin:invoke";
    NSString *output = [self find:FIND andReplaceWith:REPLACE fromInput:inputString];
    NSString *outputPath = [NSString stringWithFormat:@"%@%@%@",NSHomeDirectory(),DIR_PATH,@"system.login.console.compact.txt"];
    [output writeToFile:outputPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Read String Err:%@",error);

}

+(NSString *)find:(NSString *)find andReplaceWith:(NSString *)replace fromInput:(NSString *)input{
    return [input stringByReplacingOccurrencesOfString:find withString:replace];
}

@end
