//
//  URLValidator.h
//  MacLoginPluginInstaller
//
//  Created by Satendra Singh on 28/03/20.
//  Copyright © 2020 CoreBits Software Solutions Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface URLValidator : NSObject

+ (BOOL)validateUrlString:(NSString*)urlString;

+ (BOOL)validateTitle:(NSString*)title;

@end

NS_ASSUME_NONNULL_END
