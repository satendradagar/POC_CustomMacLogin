//
//  URLStorageManager.m
//  Compact Identity Setup
//
//  Created by Satendra Singh on 29/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//

#import "URLStorageManager.h"

#define DIR_PATH @"/Library/Application Support/compact"
#define FILE_PATH @"/Library/Application Support/compact/compactInfo.data"

@implementation URLStorageManager

+(void)saveUrl:(NSString *)url andTitle:(NSString *)titile{

    NSError *error;
    NSDictionary *dict = @{URL_KEY:url,URL_TITLE_KEY:titile};
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        NSDictionary *attr = @{NSFilePosixPermissions: @0755};
    //    [attr setValue:[NSNumber numberWithShort:0777]
    //    forKey:NSFilePosixPermissions];
    NSString *dirPath = [NSString stringWithFormat:@"%@%@",NSHomeDirectory(),DIR_PATH];
        if (NO == [[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:attr error:&error];
            NSLog(@"Err in Create Dir:%@",error);

        }
    NSString *filePath = [NSString stringWithFormat:@"%@%@",NSHomeDirectory(),FILE_PATH];

        [[NSFileManager defaultManager] createFileAtPath:filePath contents:dataFromDict attributes:attr];
}

+(NSString *)url{
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:FILE_PATH];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
    options:NSJSONReadingAllowFragments
      error:&error];
    return dict[URL_KEY];
}

+(NSDictionary *)savedInfo{
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:FILE_PATH];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
    options:NSJSONReadingAllowFragments
      error:&error];
    return dict;
}


@end
