//
//  URLValidator.m
//  MacLoginPluginInstaller
//
//  Created by Satendra Singh on 28/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//

#import "URLValidator.h"

@implementation URLValidator

+ (BOOL)validateUrlString:(NSString*)urlString
{
    // "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*)+)+(/)?(\\?.*)?"

    NSString *urlRegEx =
       @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
       NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
       return [urlTest evaluateWithObject:urlString];
}

+ (BOOL)validateTitle:(NSString*)title
{
    NSUInteger count = title.length;
    if (count > 2 && count <= 28) {
        return true;
    }
    return false;
}
@end
