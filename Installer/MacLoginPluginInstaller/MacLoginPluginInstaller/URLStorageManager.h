//
//  URLStorageManager.h
//  Compact Identity Setup
//
//  Created by Satendra Singh on 29/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


#define URL_KEY @"resetURL"
#define URL_TITLE_KEY @"resetURLTitle"


NS_ASSUME_NONNULL_BEGIN

@interface URLStorageManager : NSObject

+(void)saveUrl:(NSString *)url andTitle:(NSString *)titile;


+(NSDictionary *)savedInfo;

@end

NS_ASSUME_NONNULL_END
