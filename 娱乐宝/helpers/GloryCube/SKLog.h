//
//  SKLog.h
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSingleton.h"

/**
 *	@brief	You can use SKLog() to replace NSLog() method, and it can give you more useful information than NSLog(). The use of SKLog() is same to NSLog(). You can use "SKLogOn" instruction to open this log, and use "SKLogOff" instruction to close this log.
 */
#ifndef SKLOG_OFF
#define SKLog(id,...) \
[_SKLog logWithFile:__FILE__ \
address:self \
line:__LINE__ \
prettyFunc:__PRETTY_FUNCTION__ \
message:(id), ##__VA_ARGS__]
#define SKLogOn [_SKLog openLog];
#define SKLogOff [_SKLog closeLog];
#else
#define SKLog(id,...)
#endif

@interface _SKLog : SKSingleton

+ (void)logWithFile:(char *)file
            address:(id)address
               line:(int)line
         prettyFunc:(const char *)prettyFunc
            message:(NSString *)message, ...;
+ (void)openLog;
+ (void)closeLog;

@end
