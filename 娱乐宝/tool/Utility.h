//
//  Utility.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/20.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Const.h"

//请求类型
typedef enum _RequestStyle{
    RequestNormalStle=0,
    RequestWebServiceStyle=1
}RequestStyle;

@interface Utility : NSObject

#pragma mark -
#pragma mark -System Code
+(AppDelegate *)delegate;
+(CGFloat)isVerson;
+(NSString *)iosLanguage;

#pragma mark -
#pragma mark NSString Code
+ (UIColor *)colorForTitle:(NSString *)colorTitle;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)trim:(NSString *)str;
+ (BOOL) isBlank:(NSString *)str;
+ (BOOL) notBlank:(NSString *)str;
+ (NSString *)int2Str:(NSInteger)code;
+ (BOOL)string:(NSString *)strs contain:(NSString *)str;
+ (BOOL)stringEquals:(NSString *)str1 to:(NSString *)str2;
+ (BOOL)caseEquals:(NSString *)str1 to:(NSString *)str2;
+ (BOOL)startWith:(NSString *)prefix forString:(NSString *)text;
+ (BOOL)endWith:(NSString *)suffix forString:(NSString *)text;
+ (BOOL)stringIsAllNumber:(NSString *)string;
#pragma mark - 
#pragma mark - NSDate Code
+ (NSString *)converToString:(double)num;
+ (NSString *)date2Str:(NSDate *)date patten:(NSString *)patten;
+ (NSString *)currentDatetimeWithPatten:(NSString *)patten;
+ (NSString *)currentDateTime;
+ (NSString *)currentTimeWithPatten:(NSString *)patten;
+ (NSString *)currentTime;

+ (NSDate *)str2Date:(NSString *)str patten:(NSString *)patten;
+ (NSDate *)str2DateTime:(NSString *)str patten:(NSString *)patten;
+ (NSDate *)str2Date:(NSString *)str;
+ (NSString *)datetime2time:(NSString *)datetime;
+ (NSInteger)minBetweenOneDate:(NSString *)oneDate
                       twoDate:(NSString *)twoDate;

+ (NSInteger)minuteBetweenOneDate:(NSString *)oneDate
                          twoDate:(NSString *)twoDate;
+ (NSTimeInterval)timeIntervalFirstTime :(NSString *)firstTime
                              secondTime:(NSString *)secondTime;
+ (NSString *)anotherSystemTime:(NSTimeInterval )timeInterval;
#pragma mark -
#pragma mark NSURL Code
+ (NSString *)formatURLStr:(NSString *)str;
+ (NSString *)interface:(NSString *)interface
                 params:(NSMutableDictionary *)params;

#pragma mark - 
#pragma mark UIKit Code

+ (void)alert:(NSString *)message
        title:(NSString *)title
       buttom:(NSString *)button;
+ (void)alert:(NSString *)message
        title:(NSString *)title;
+ (void)alert:(NSString *)message;
+ (void)tkAlert:(NSString *)message
      imageName:(NSString *)imageName;
+ (void)blockBorderWith:(UIView *)view;
+ (UIColor *)color16:(NSString *)color;
+ (void)borderView:(UIView *)view
      cornerRadius:(CGFloat)cornerRadius
              width:(CGFloat)width
             color:(UIColor *)color;
+ (void)defaultBorder:(UIView *)view;
#pragma mark-
#pragma mark -alert
+ (void)showAlwetWithTitle:(NSString *)title
                   content:(NSString *)content
              cancelButton:(NSString *)cancel;

@end
