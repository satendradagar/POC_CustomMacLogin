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
    NSString *urlRegEx =
       @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
       NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
       return [urlTest evaluateWithObject:urlString];
    
//    if (!urlString)
//    {
//        return NO;
//    }
//
//    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
//
//    NSRange urlStringRange = NSMakeRange(0, [urlString length]);
//    NSMatchingOptions matchingOptions = 0;
//
//    if (1 != [linkDetector numberOfMatchesInString:urlString options:matchingOptions range:urlStringRange])
//    {
//        return NO;
//    }
//
//    NSTextCheckingResult *checkingResult = [linkDetector firstMatchInString:urlString options:matchingOptions range:urlStringRange];
//
//    return checkingResult.resultType == NSTextCheckingTypeLink && NSEqualRanges(checkingResult.range, urlStringRange);
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
