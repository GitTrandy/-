//
//  SKSingleton.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKSingleton.h"
#import <libkern/OSAtomic.h>

@interface SKSingleton ()

@end

@implementation SKSingleton
{}
#pragma mark -
#pragma mark Super Methods
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

#pragma mark -
#pragma mark Public Methods
+ (id)sharedInstance {
    return [self _sharedInstance:&sharedInstance];
}

+ (id)_sharedInstance:(void * volatile *)instance {
//    @synchronized(self)
//    {
//        if (*instance == nil)
//            *instance = [[self alloc] init];
//    }
//    return *instance;
    
    while (!*instance) {
        typeof(self) temp = [[self alloc] init];
        if(!OSAtomicCompareAndSwapPtrBarrier(0x0, temp, instance)) {
            [temp release];
        }
    }
    return *instance;
}

+ (id)_allocWithZone:(NSZone *)zone forInstance:(void * volatile *)instance {
//    @synchronized(self) {
//        if (*instance == nil) {
//            *instance = [super allocWithZone:zone];
//            return *instance;  // assignment and return on first allocation
//        }
//    }
//    return nil; // on subsequent allocation attempts return nil
    
    while (!*instance) {
        id temp = [super allocWithZone:zone]; // id 相当于 void *
        if(!OSAtomicCompareAndSwapPtrBarrier(0x0, temp, instance)) {
            [temp release];
            return nil;
        }
    }
    return *instance;
}

//+ (id)sharedInstance {
//    static id sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//        // Do any other initialisation stuff here
//    });
//    return sharedInstance;
//}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods

@end
