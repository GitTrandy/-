//
//  SKSingleton.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <Foundation/Foundation.h>

//static id sharedInstance = nil;
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-variable"
static void * volatile sharedInstance = nil;
#pragma GCC diagnostic pop

#define DEFINE_SHARED_INSTANCE + (id)sharedInstance {  return [self _sharedInstance:&sharedInstance]; } \
+ (id)allocWithZone:(NSZone *)zone { return [self _allocWithZone:zone forInstance:&sharedInstance]; }

/**
 *	@brief	This class is used for implementing a singleton mode. All the same, after subclassing this class and doing some settings, you can implement many songletons.
 */
@interface SKSingleton : NSObject

/*
 Subclassing this class and implementing a singleton：
 
 .h file：
 @interface Test1 : SKSingleton
 
 @end
 
 .m file：
 #import "Test1.h"
 
 @implementation Test1
 
 DEFINE_SHARED_INSTANCE
 
 @end
 
 To do that, the "Test1" is a singleton class now. And you can custom this class by adding some properties to save some information.
 */

+ (id)sharedInstance;
+ (id)_sharedInstance:(void * volatile *)instance;
+ (id)_allocWithZone:(NSZone *)zone forInstance:(void * volatile *)instance;

@end
