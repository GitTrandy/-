//
//  SKLog.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKLog.h"
#import <UIKit/UIKit.h>
#import "SKUtil.h"

@interface _SKLog ()

@property (nonatomic, assign) BOOL isCloseLog; // 是否关闭了log，默认为NO，表示正在log

@end

@implementation _SKLog

#pragma mark -
#pragma mark Super Methods
//- (void)dealloc {
//    // Release code
//    [super dealloc];
//}
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

//DEFINE_SHARED_INSTANCE

#pragma mark -
#pragma mark Public Methods
+ (void)logWithFile:(char *)file
            address:(id)address
               line:(int)line
         prettyFunc:(const char *)prettyFunc
            message:(NSString *)message, ... {
    if (![[_SKLog sharedInstance] isCloseLog]) {
        va_list listOfArguments;
        NSString *formattedString;
        NSString *sourceFile;
        NSString *prettyFunction;
        NSString *logString;
        
        va_start(listOfArguments, message);
        formattedString = [[NSString alloc] initWithFormat:message arguments:listOfArguments];
        va_end(listOfArguments);
        
        sourceFile = [[NSString alloc] initWithBytes:file length:strlen(file) encoding:NSUTF8StringEncoding];
        prettyFunction = [[NSString alloc] initWithBytes:prettyFunc length:strlen(prettyFunc) encoding:NSUTF8StringEncoding];
        
        NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[prettyFunction componentsSeparatedByCharactersInSet:separatorSet]];
        [array removeObject:@""];
        
        if ([array count] >= 2) {
            logString = [NSString stringWithFormat:@"<<< SKLog >>> [File %@][Address %p][Class %@][Method %@][Line %d] %@", [sourceFile lastPathComponent], address, [array objectAtIndex:0], [array objectAtIndex:1], line, formattedString];
        } else {
            logString = @"";
        }
        
        NSLog(@"%@", logString);
        
        [formattedString release];
        [sourceFile release];
        [prettyFunction release];
        
        //    return;
    }
}

/*
 根据 源码文件、行号、格式化字符串 输出日志信息
 */
+ (void)logWithFile:(char *)file
               line:(int)line
            message:(NSString *)message, ... {
    
}

+ (void)openLog {
    [[_SKLog sharedInstance] setIsCloseLog:NO];
}

+ (void)closeLog {
    [[_SKLog sharedInstance] setIsCloseLog:YES];
}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_exitApplicationWithParams:(NSDictionary *)params {
    
    CGFloat duration = [[params objectForKey:@"duration"] floatValue];
    SKExitApplicationAnimationStyle animationStyle = [[params objectForKey:@"animationStyle"] integerValue];
    
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:duration]; // 0.5 s
    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:win cache:NO];
    //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:win cache:NO];
    [UIView setAnimationTransition:(UIViewAnimationTransition)animationStyle forView:win cache:YES];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)]; // animationFinished:finished:context:
    win.bounds = CGRectMake(0, 0, 0, 0);
    win.alpha = 0;
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if ([animationID compare:@"exitApplication"] == 0) {
        
        //        NSLog(@"--- %@, %@, %@", animationID, finished, context);
        
        exit(0);
    }
}

@end
