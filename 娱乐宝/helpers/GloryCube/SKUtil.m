//
//  SKUtil.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKUtil.h"
#import <objc/runtime.h>
#import "SKLog.h"

@implementation NSObject (dictionary)

- (NSMutableDictionary *)getDictionary
{
    if (objc_getAssociatedObject(self, @"dictionary") == nil)
    {
        objc_setAssociatedObject(self,@"dictionary",[[[NSMutableDictionary alloc] init] autorelease],OBJC_ASSOCIATION_RETAIN);
    }
    return (NSMutableDictionary *)objc_getAssociatedObject(self, @"dictionary");
}

- (void)setAdditionalValue:(id)value forKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"dictionary.%@", key];
    [self setValue:value forKeyPath:keyPath];
}


- (id)additionalValueForKey:(NSString *)key {
    NSString *keyPath = [NSString stringWithFormat:@"dictionary.%@", key];
    id value = [self valueForKeyPath:keyPath];
    return value;
}

@end

static void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"... CRASH:\n%@", exception);
    NSLog(@"... Stack Trace:\n%@", [exception callStackSymbols]);
}

@interface _SKLog ()

- (void)_exitApplicationWithParams:(NSDictionary *)params;

@end

@implementation SKUtil

/*
 一个用于测试的方法
 */
+ (void)test {
    NSLog(@"This is a test !!!");
}

/*
 返回框架的Bundle对象
 */
+ (NSBundle *)frameworkBundle {
    static NSBundle *frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"SimpleKit.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return frameworkBundle;
}

/*
 根据文件名称、文件类型返回Bundle中的Image对象
 */
+ (UIImage *)imageFromBundleWithName:(NSString *)name ofType:(NSString *)type {
    NSBundle *fmBundle = [SKUtil frameworkBundle];
    NSString *path = [fmBundle pathForResource:name ofType:type];
    UIImage *img = [UIImage imageWithContentsOfFile:path];
    return img;
}

#pragma mark -
#pragma mark Border Code
/*
 给 view 添加边框
 */
+ (void)borderWithView:(UIView *)view {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:NO];
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:5];
}

/**
 *	@brief	给 view 添加边框
 *
 *	@param 	view 	需要添加边框的 view
 *	@param 	masksToBounds 	masksToBounds
 */
+ (void)borderWithView:(UIView *)view masksToBounds:(BOOL)masksToBounds {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:masksToBounds];
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:5];
}

/*
 给 view 添加指定颜色 color 的边框
 */
+ (void)borderWithView:(UIView *)view color:(UIColor *)color {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:NO];
    [[view layer] setBorderColor:color.CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:5];
}

/**
 *	@brief	给 view 添加边框
 *
 *	@param 	view 	需要添加边框的 view
 *	@param 	color 	边框的颜色
 *	@param 	masksToBounds 	masksToBounds
 */
+ (void)borderWithView:(UIView *)view color:(UIColor *)color masksToBounds:(BOOL)masksToBounds {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:masksToBounds];
    [[view layer] setBorderColor:color.CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:5];
}

/*
 给 view 添加边角弧度为 radius 的边框
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:NO];
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:radius];
}

/**
 *	@brief	给 view 添加边框
 *
 *	@param 	view 	需要添加边框的 view
 *	@param 	radius 	边框边角半径
 *	@param 	masksToBounds 	是否掩盖边界
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius masksToBounds:(BOOL)masksToBounds {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:masksToBounds];
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:radius];
}

/**
 *	@brief	给 view 添加边框
 *
 *	@param 	view 	需要添加边框的 view
 *	@param 	radius 	边框边角半径
 *	@param 	color 	边框的颜色
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius color:(UIColor *)color {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:NO];
	[[view layer] setBorderColor:color.CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:radius];
}

/**
 *	@brief	给 view 添加边框
 *
 *	@param 	view 	需要添加边框的 view
 *	@param 	radius 	边框边角半径
 *	@param 	color 	边框的颜色
 *	@param 	masksToBounds 	是否掩盖边界
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius color:(UIColor *)color masksToBounds:(BOOL)masksToBounds {
    [[view layer] setShouldRasterize:YES];
    [[view layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [[view layer] setMasksToBounds:masksToBounds];
	[[view layer] setBorderColor:color.CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setCornerRadius:radius];
}

/*
 根据 网页视图 得到 页面标题
 */
+ (NSString *)titleFromWebView:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    return title;
}

/*
 根据 网页视图 执行 JavaScript脚本 返回执行结果为字符串
 */
+ (NSString *)executeScript:(NSString *)script atWebView:(UIWebView *)webView {
    NSString *script1 = @"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function myFunction() { ";
    
    NSString *script2 = script;
    
    NSString *script3 = @"}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    
    NSString *script4 = [NSString stringWithFormat:@"%@%@%@", script1, script2, script3];
    
    [webView stringByEvaluatingJavaScriptFromString:script4];
    NSString *returnStr = [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    return returnStr;
}

/*
 根据 服务器域（如：10.200.16.5，没有端口号和协议）清除系统中保存的session
 */
+ (void)clearSessionWithDomain:(NSString *)domain {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        
        NSLog(@"...cookie=%@", cookie);
        
        if ([domain isEqualToString:[cookie domain]]) {
            [storage deleteCookie:cookie];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 根据 value 和 key 新增共享信息到设备中
 */
+ (void)addSharedInfoWithValue:(NSString *)value forKey:(NSString *)key {
    // 新增
    // 一个mutable字典结构存储item信息
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    // 确定所属的类class
    [dic setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    // 设置其他属性attributes
    [dic setObject:key/*@"testAcct"*/ forKey:(id)kSecAttrAccount];
    // 添加密码 secValue  注意是object 是 NSData
    [dic setObject:[value/*@"password"*/ dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecValueData];
    // SecItemAdd
    SecItemAdd((CFDictionaryRef)dic, NULL);
    //    OSStatus s = SecItemAdd((CFDictionaryRef)dic, NULL);
    //    NSLog(@"add : %ld",s);
}

/*
 根据 key 删除设备中存放的共享信息
 */
+ (void)deleteSharedInfoWithKey:(NSString *)key {
    // 删除
    // 删除的条件
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           key/*@"testAcct"*/, kSecAttrAccount,
                           nil];
    // SecItemDelete
    SecItemDelete((CFDictionaryRef)query);
    //    OSStatus status = SecItemDelete((CFDictionaryRef)query);
    //    NSLog(@"delete: %ld", status); // errSecItemNotFound 就是没有
}

/*
 根据 value 和 key 更新共享信息
 */
+ (void)updateSharedInfoWithValue:(NSString *)value forKey:(NSString *)key {
    // 修改
    // 先查找看看有没有
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           key/*@"account"*/, kSecAttrAccount,
                           kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFTypeRef result = nil;
    if (SecItemCopyMatching((CFDictionaryRef)query, &result) == noErr) {
        // 更新后的数据，基础是搜到的result
        NSMutableDictionary *update = [NSMutableDictionary dictionaryWithDictionary:[(NSDictionary *)result autorelease]];
        // 修改要更新的项，注意先加后删的class项
        [update setObject:[query objectForKey:kSecClass] forKey:kSecClass];
        [update setObject:[value/*@"12345678"*/ dataUsingEncoding:NSUTF8StringEncoding] forKey:kSecValueData];
        [update removeObjectForKey:kSecClass];
#if TARGET_IPHONE_SIMULATOR
        // 模拟器的都有个默认的组“test”，删了，不然会出错
        //[update removeObjectForKey:(id)kSecAttrAccessGroup];
#endif
        // 得到要修改的item，根据result，但要添加class
        NSMutableDictionary *updateItem = [NSMutableDictionary dictionaryWithDictionary:result];
        [updateItem setObject:[query objectForKey:(id)kSecClass] forKey:(id)kSecClass];
        // SecItemUpdate
        SecItemUpdate((CFDictionaryRef)updateItem, (CFDictionaryRef)update);
        //        OSStatus status = SecItemUpdate((CFDictionaryRef)updateItem, (CFDictionaryRef)update);
        //        NSLog(@"update: %ld", status);
    }
}

/*
 查看所有的共享信息
 */
+ (void)showAllSharedInfo {
    // 查找全部
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           kSecMatchLimitAll, kSecMatchLimit,
                           kCFBooleanTrue, kSecReturnAttributes,
                           nil
                           ];
    CFTypeRef result = nil;
    SecItemCopyMatching((CFDictionaryRef)query, &result);
    //    OSStatus s = SecItemCopyMatching((CFDictionaryRef)query, &result);
    //    NSLog(@"select all : %ld", s);
    NSLog(@"showAllSharedInfo : %@", [(NSDictionary *)result autorelease]);
}

/*
 根据 key 查找对应共享信息的 value
 */
+ (NSString *)searchSharedInfoValueWithKey:(NSString *)key {
    
    NSString *ret = nil;
    
    // 按名称查找，查找条件：1.class 2.attributes 3.search option
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           key/*@"account"*/, kSecAttrAccount,
                           kCFBooleanTrue, kSecReturnAttributes, 
                           nil];
    CFTypeRef result = nil;
    // 先找到一个item
    OSStatus s = SecItemCopyMatching((CFDictionaryRef)query, &result);
    //    NSLog(@"select name : %ld", s); // errSecItemNotFound 就是找不到
    //    NSLog(@"%@", result);
    if (s == noErr) {
        // 继续查找item的secValue
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[(NSDictionary *)result autorelease]];
        
        // 存储格式
        [dic setObject:(id)kCFBooleanTrue forKey:kSecReturnData];
        // 确定class
        [dic setObject:[query objectForKey:kSecClass] forKey:kSecClass];
        NSData *data = nil;
        // 查找secValue
        if (SecItemCopyMatching((CFDictionaryRef)dic, (CFTypeRef *)&data) == noErr) {
            if (data.length) {
                //                NSLog(@"%@", [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
                ret = [[[NSString alloc] initWithData:[(NSData *)data autorelease] encoding:NSUTF8StringEncoding] autorelease];
            }
        }
    }
    
    return ret;
}

/*
 删除所有的共享信息
 */
+ (void)deleteAllSharedInfo {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           kSecMatchLimitAll, kSecMatchLimit,
                           kCFBooleanTrue, kSecReturnAttributes,
                           nil
                           ];
    CFTypeRef result = nil;
    SecItemCopyMatching((CFDictionaryRef)query, &result);
    NSArray *array = [NSArray arrayWithArray:result];
    for (int i = 0; i < [array count]; i++) {
        NSString *account = [[array objectAtIndex:i] objectForKey:kSecAttrAccount];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             kSecClassGenericPassword, kSecClass,
                             account, kSecAttrAccount,
                             kCFBooleanTrue, kSecReturnAttributes, 
                             nil];
        SecItemDelete((CFDictionaryRef)dic);
    }
}

/*
 根据 日期对象 返回 日期字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}

/**
 *	@brief	返回格式化的日期字符串
 *
 *	@param 	date 	日期对象
 *	@param 	dataFormat 	时间格式字符串 如：yyyy-MM-dd HH:mm:ss
 *
 *	@return	格式化的日期字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:dateFormat];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSString *dateStr = [df stringFromDate:date];
    return dateStr;
}

/*
 根据 日期字符串 返回 日期对象
 */
+ (NSDate *)dateWithString:(NSString *)dateString {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSDate *date = [df dateFromString:dateString];
    return date;
}

/**
 *	@brief	根据 日期字符串 返回 日期对象
 *
 *	@param 	dateString 	日期字符串
 *	@param 	dateFormat 	时间格式字符串 如：yyyy-MM-dd HH:mm:ss
 *
 *	@return	日期对象
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:dateFormat];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    NSDate *date = [df dateFromString:dateString];
    return date;
}

/*
 根据 key值 从存储信息中取出 对象值
 */
+ (NSObject *)objectFromSavedInfoWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *obj = [defaults objectForKey:key];
    return obj;
}

/*
 根据 key值 将 对象 保存到存储信息中
 */
+ (void)saveToSavedInfoWithObject:(NSObject *)object andKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

/*
 根据 彩色图片 处理返回 黑白图片
 */
+ (UIImage *)grayscaleImageWithImage:(UIImage *)image {
    /*
     const UInt8 luminance = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722); // Good luminance value
     */
    // Create a gray bitmap contxt
    const size_t width = image.size.width;
    const size_t height = image.size.height;
    
    CGRect imageRect = CGRectMake(0, 0, width, height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/* Bits per component 即一个字节 即0~255，也就是RGB颜色空间 */, width * 3, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (!bmContext) {
        return nil;
    }
    
    // Image quality
    CGContextSetShouldAntialias(bmContext, false);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    // Draw the image in the bitmap context
    CGContextDrawImage(bmContext, imageRect, image.CGImage);
    
    // Create an image object from the context
    CGImageRef grayscaledImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *grayscaledImage = [UIImage imageWithCGImage:grayscaledImageRef scale:image.scale orientation:image.imageOrientation];
    // Cleanup
    CGImageRelease(grayscaledImageRef);
    CGContextRelease(bmContext);
    
    return grayscaledImage;
}

#pragma mark -
#pragma mark System Code
/*
 iOS6以下，启动程序强制横屏
 */
+ (void)forceLandscape {
    // 启动强制横屏，如果不加下面的代码，在iOS6上能够自动横屏，但是在iOS6以下就不行了
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation != UIDeviceOrientationLandscapeLeft && orientation != UIDeviceOrientationLandscapeRight) {
        orientation = UIDeviceOrientationLandscapeLeft;
    } 
    [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)orientation];
}

/*
 返回当前设备的版本号的浮点数值
 */
+ (CGFloat)floatValueOfCurrentDeviceVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/**
 *	@brief	捕获系统运行异常
 */
+ (void)caughtException {
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

/**
 *	@brief	set the app should disable autolock the screen
 *
 *	@param 	autoLock 	If YES, the app should disable autolock the screen; NO, not disable.
 */
+ (void)applicationShouldDisableAutolockScreen:(BOOL)autoLock {
    [[UIApplication sharedApplication] setIdleTimerDisabled:autoLock];
}

/**
 *	@brief	（退出当前运行的程序，并可以指定退出动画的样式）exit the current running application, and you can specify the animation style
 *
 *	@param 	animated 	（是否显示退出动画）If YES, should use animation; NO, not animated.
 *  @param 	duration 	（动画时间）animation duration.
 *	@param 	animationStyle 	（动画效果）animation style
 */
+ (void)exitApplication:(BOOL)animated duration:(CGFloat)duration options:(SKExitApplicationAnimationStyle)animationStyle {
    
    NSDictionary *params = @{
                             @"animated": [NSNumber numberWithBool:animated],
                             @"duration": [NSNumber numberWithFloat:duration],
                             @"animationStyle": [NSNumber numberWithInteger:animationStyle]
                             };
    
    [[_SKLog sharedInstance] performSelector:@selector(_exitApplicationWithParams:) withObject:params afterDelay:0.0f];
}

/**
 *	@brief	（退出当前运行的程序，并可以指定退出动画的样式）exit the current running application, and you can specify the animation style
 *
 *	@param 	animated 	（是否显示退出动画）If YES, should use animation; NO, not animated.
 *  @param 	duration 	（动画时间）animation duration.
 *	@param 	animationStyle 	（动画效果）animation style
 *	@param 	delay 	（退出延迟时间）the after delay time for exiting app
 */
+ (void)exitApplication:(BOOL)animated duration:(CGFloat)duration options:(SKExitApplicationAnimationStyle)animationStyle afterDelay:(CGFloat)delay {
    
    NSDictionary *params = @{
                             @"animated": [NSNumber numberWithBool:animated],
                             @"duration": [NSNumber numberWithFloat:duration],
                             @"animationStyle": [NSNumber numberWithInteger:animationStyle]
                             };
    
    [[_SKLog sharedInstance] performSelector:@selector(_exitApplicationWithParams:) withObject:params afterDelay:delay];
}

/**
 *	@brief	根据 函数代码块 返回函数指针（将block代码块作为一个函数指针对象返回）
 *
 *	@param 	code 	函数代码块
 *
 *	@return	函数指针
 */
+ (id)functionPointWithCode:(id)code {
    return [Block_copy(
                       code
                       ) autorelease];
}

#pragma mark -
#pragma mark UI Code
/**
 *	@brief	给controller添加左边的 bar button。
 *
 *	@param 	title 	title
 *	@param 	target 	target
 *	@param 	action 	action
 *	@param 	controller 	controller
 */
+ (void)addLeftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action toController:(UIViewController *)controller
 {
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStyleBordered) target:target action:action] autorelease];
    [controller.navigationItem setLeftBarButtonItem:item];
}

/**
 *	@brief	给controller添加右边的 bar button。
 *
 *	@param 	title 	title
 *	@param 	target 	target
 *	@param 	action 	action
 *	@param 	controller 	controller
 */
+ (void)addRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action toController:(UIViewController *)controller
{
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStyleBordered) target:target action:action] autorelease];
    [controller.navigationItem setRightBarButtonItem:item];
}

/**
 *	@brief	将controller以Modal方式从fromController上显示出来
 *
 *	@param 	controller 	controller
 *	@param 	fromController 	fromController
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController
 {
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        [fromController presentModalViewController:controller animated:YES];
    } else {
        [fromController presentViewController:controller animated:YES completion:nil];
    }
}

/**
 *	@brief	将 controller 以Modal方式从 fromController 上显示出来
 *
 *	@param 	controller 	controller description
 *	@param 	fromController 	fromController description
 *	@param 	transitionStyle 	transitionStyle description
 *	@param 	presentationStyle 	presentationStyle description
 *	@param 	size 	size description
 *	@param 	center 	center description
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController modalTransitionStyle:(UIModalTransitionStyle)transitionStyle modalPresentationStyle:(UIModalPresentationStyle)presentationStyle contentSize:(CGSize)size contentCenter:(CGPoint)center {
    
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    
    controller.modalTransitionStyle = transitionStyle;
    controller.modalPresentationStyle = presentationStyle;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        [fromController presentModalViewController:controller animated:YES];
    } else {
        [fromController presentViewController:controller animated:YES completion:nil];
    }
    
    [controller.view.superview setFrame:frame];
    [controller.view.superview setCenter:center];
}

/**
 *	@brief	在 fromView 附近显示出 popover controller。
 *
 *	@param 	popController 	显示的 popover controller。注意：popover controller 必须声明为所属对象的属性
 *	@param 	fromView 	popover controller 箭头指向的视图
 *	@param 	inView 	popover controller 显示时所在的视图
 *	@param 	size 	popover controller 显示的尺寸
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size
 {
    /*
     下方convertRect:后面一定要是view的bounds，如果为frame的话，转换过后得到的rect就会有
     frame的origin偏移，导致后面的显示位置出错。
     */
//    CGRect rect = [_contentView convertRect:[[_segmentBarItems objectAtIndex:index] bounds] fromView:[_segmentBarItems objectAtIndex:index]];
//    rect.origin.y = rect.origin.y - 10;
//    [_pop setPopoverContentSize:CGSizeMake(c.view.bounds.size.width, c.view.bounds.size.height + nav.navigationBar.bounds.size.height)];
//    [_pop presentPopoverFromRect:rect inView:_contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:NO];
    
    CGRect rect = [inView convertRect:[fromView bounds] fromView:fromView];
    rect.origin.y = rect.origin.y - 10;
    [popController setPopoverContentSize:size];
    [popController presentPopoverFromRect:rect inView:inView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:NO];
}

/**
 *	@brief	在 fromView 附近显示出 popover controller。
 *
 *	@param 	popController 	显示的 popover controller。注意：popover controller 必须声明为所属对象的属性
 *	@param 	fromView 	popover controller 箭头指向的视图
 *	@param 	inView 	popover controller 显示时所在的视图
 *	@param 	size 	popover controller 显示的尺寸
 *	@param 	directions 	popover controller 显示的箭头方向
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size arrowDirections:(UIPopoverArrowDirection)directions
{
    CGRect rect = [inView convertRect:[fromView bounds] fromView:fromView];
    rect.origin.y = rect.origin.y - 10;
    [popController setPopoverContentSize:size];
    [popController presentPopoverFromRect:rect inView:inView permittedArrowDirections:directions animated:YES];
}

/**
 *	@brief	在 fromView 附近显示出 popover controller。
 *
 *	@param 	popController 	显示的 popover controller。注意：popover controller 必须声明为所属对象的属性
 *	@param 	fromView 	popover controller 箭头指向的视图
 *	@param 	inView 	popover controller 显示时所在的视图
 *	@param 	size 	popover controller 显示的尺寸
 *	@param 	offset 	popover controller 内容视图位置的偏移量
 *	@param 	directions 	popover controller 显示的箭头方向
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size popoverContentOffset:(CGPoint)offset arrowDirections:(UIPopoverArrowDirection)directions {
    
    CGRect rect = [inView convertRect:[fromView bounds] fromView:fromView];
    rect.origin.x = rect.origin.x + -offset.x;
    [popController setPopoverContentSize:size];
    [popController presentPopoverFromRect:rect inView:inView permittedArrowDirections:directions animated:YES];
    
    rect = popController.contentViewController.view.superview.superview.superview.frame;
    rect.origin.x = rect.origin.x + offset.x;
    rect.origin.y = rect.origin.y + offset.y;
    [popController.contentViewController.view.superview.superview.superview setFrame:rect];
}

/**
 *	@brief	使present出来的view controller消失
 *
 *	@param 	controller 	之前被present的controller
 *	@param 	animated 	是否动画
 */
+ (void)dismissViewController:(UIViewController *)controller animated:(BOOL)animated {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        [controller dismissModalViewControllerAnimated:animated];
    } else {
        [controller dismissViewControllerAnimated:animated completion:nil];
    }
}

/**
 *	@brief	将controller以Modal方式从fromController上显示出来
 *
 *	@param 	controller 	controller description
 *	@param 	fromController 	fromController description
 *	@param 	transitionStyle 	transitionStyle description
 *	@param 	presentationStyle 	presentationStyle description
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController transitionStyle:(UIModalTransitionStyle)transitionStyle presentationStyle:(UIModalPresentationStyle)presentationStyle
{
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        [fromController presentModalViewController:controller animated:YES];
    } else {
        [fromController presentViewController:controller animated:YES completion:nil];
    }
}

//#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
+ (void)makeViewToLandscape:(UIView *)view { // 将视图预先设置为横屏模式（目的是处理那些虽然已经设置view为landscape，但是只能等到动画加载完成之后才能变换为横屏的bug）
    // assumes self.view is landscape and view is portrait（假设self.view是横屏，而view是竖屏）
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    UIViewController *root = window.rootViewController;
//    [view setCenter:CGPointMake(root.view.frame.size.width / 2, root.view.frame.size.height / 2)];
//    
//    CGFloat radians = 90 / 180.0 * M_PI;
//    CGAffineTransform cgCTM = CGAffineTransformMakeRotation(radians);
//    
//    //    CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
//    view.transform = cgCTM;
//    view.bounds = root.view.bounds;
    
    
    // assumes self.view is landscape and view is portrait（假设self.view是横屏，而view是竖屏）
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *root = window.rootViewController;
    [view setCenter:CGPointMake(root.view.frame.size.width / 2, root.view.frame.size.height / 2)];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat rotationAngle = 0.0f;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            rotationAngle = 0.0f;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            rotationAngle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            rotationAngle = -M_PI / 2.0f;
            view.bounds = CGRectMake(0, 0, 1024, 708);
            break;
        case UIInterfaceOrientationLandscapeRight:
            rotationAngle = M_PI / 2.0f;
            view.bounds = CGRectMake(0, 0, 1024, 748);
            break;
        default:
            break;
    }
    
    
    CGFloat radians = rotationAngle;//90 / 180.0 * M_PI;
    CGAffineTransform cgCTM = CGAffineTransformMakeRotation(radians);
    
    //    CGAffineTransform cgCTM = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
    view.transform = cgCTM;
    //    view.bounds = root.view.bounds;
}

/**
 *	@brief	切换整个窗体的界面
 *
 *	@param 	controller 	需要切换到的controller
 *	@param 	duration 	切换动画执行的时间
 *	@param 	options 	切换动画的设置项
 */
+ (void)switchViewWithController:(UIViewController *)controller duration:(CGFloat)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {
    
//    UIView *view = controller.view;
//    [SKUtil makeViewToLandscape:view];
//    
//    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
//    [UIView transitionWithView:win
//                      duration:duration
//                       options:options
//                    animations:^{
//                        
//                        [win setRootViewController:controller];
//                    }
//                    completion:completion];
    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationTransition:options forView:window cache:YES];
//    [window.rootViewController.view removeFromSuperview];
//    [UIView commitAnimations];
//    
//    [window setRootViewController:controller];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [UIView transitionWithView:window duration:duration options:options animations:^{
        [window.rootViewController.view removeFromSuperview];
    } completion:completion];
    
    [window setRootViewController:controller];
    
}

/**
 *	@brief	Switch the base interface in the window.
 *
 *	@param 	controller 	The controller which you want to switch to.
 *	@param 	window      The window which includes the controller.
 *	@param 	duration 	The duration of the animation.
 *	@param 	options 	The options of the animation.
 */
+ (void)switchViewWithController:(UIViewController *)controller inWindow:(UIWindow *)window duration:(CGFloat)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {
    
    [UIView transitionWithView:window duration:duration options:options animations:^{
        [window.rootViewController.view removeFromSuperview];
    } completion:completion];
    
    [window setRootViewController:controller];
}

/**
 *	@brief	get an animated image view object
 *
 *	@param 	frame 	frame
 *	@param 	duration 	duration
 *	@param 	images 	array of images
 *	@param 	repeatCount 	Specifies the number of times to repeat the animation. 0 means countless times.
 *
 *	@return	an animated image view object
 */
+ (UIImageView *)animatedImageViewWithFrame:(CGRect)frame duration:(CGFloat)duration images:(NSArray *)images repeatCount:(NSInteger)repeatCount {
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationImages:images];
    [imageView setAnimationRepeatCount:repeatCount];
    [imageView startAnimating];
    return imageView;
}

/**
 *	@brief	Judge whether the textField's text is null.
 *
 *	@param 	textField 	The text field.
 *
 *	@return	If YES, the textField's text is null; NO, not null.
 */
+ (BOOL)isNullWithTextField:(UITextField *)textField {
    if (textField.text == nil || [textField.text isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -
#pragma mark Color Code
/**
 *	@brief	根据16进制的字符串返回单个颜色组件的浮点数颜色值（#RGB、#ARGB、#RRGGBB、#AARRGGBB）
 *
 *	@param 	string 	16进制的字符串
 *	@param 	start 	16进制的字符串中某个颜色组件字符串的开始位置
 *	@param 	length 	16进制的字符串中某个颜色组件字符串的长度
 *
 *	@return	单个颜色组件的浮点数颜色值
 */
+ (CGFloat)_colorComponentFromHexString:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

/**
 *	@brief	根据16进制的颜色值字符串返回颜色对象（#RGB、#ARGB、#RRGGBB、#AARRGGBB）
 *
 *	@param 	hexString 	16进制的颜色值字符串
 *
 *	@return	颜色对象
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, green, blue;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [SKUtil _colorComponentFromHexString:colorString start:0 length:1];
            green = [SKUtil _colorComponentFromHexString:colorString start:1 length:1];
            blue  = [SKUtil _colorComponentFromHexString:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [SKUtil _colorComponentFromHexString:colorString start:0 length:1];
            red   = [SKUtil _colorComponentFromHexString:colorString start:1 length:1];
            green = [SKUtil _colorComponentFromHexString:colorString start:2 length:1];
            blue  = [SKUtil _colorComponentFromHexString:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [SKUtil _colorComponentFromHexString:colorString start:0 length:2];
            green = [SKUtil _colorComponentFromHexString:colorString start:2 length:2];
            blue  = [SKUtil _colorComponentFromHexString:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [SKUtil _colorComponentFromHexString:colorString start:0 length:2];
            red   = [SKUtil _colorComponentFromHexString:colorString start:2 length:2];
            green = [SKUtil _colorComponentFromHexString:colorString start:4 length:2];
            blue  = [SKUtil _colorComponentFromHexString:colorString start:6 length:2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark -
#pragma mark String Code
/**
 *	@brief	判断一个字符串中是否包含另一个字符串
 *
 *	@param 	findString 	要搜索的字符串
 *	@param 	fromString 	源字符串
 *
 *	@return	YES，包含；NO，不包含。
 */
+ (BOOL)containString:(NSString *)findString fromString:(NSString *)fromString {
    
    if (findString == nil || fromString == nil) {
        return NO;
    }
    
    NSRange range = [fromString rangeOfString:findString];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *	@brief	Get the localized string for multi-language environment with the key string.
 *
 *	@param 	key 	The key string.
 *
 *	@return	The localized string
 */
+ (NSString *)localizedStringWithKey:(NSString *)key {
    return NSLocalizedString(key, @"");
}

/**
 *	@brief	判断一个字符串中是否包含数组中的字符串，只要有一个匹配就认为是包含
 *
 *	@param 	findStrings 	要搜索的字符串数组
 *	@param 	fromString 	源字符串
 *
 *	@return	YES，包含；NO，不包含。
 */
+ (BOOL)containStrings:(NSArray *)findStrings fromString:(NSString *)fromString {
    if (findStrings == nil || fromString == nil) {
        return NO;
    }
    
    for (NSString *str in findStrings) {
        BOOL isContain = [self.class containString:str fromString:fromString];
        if (isContain) {
            return YES;
        }
    }
    
    return NO;
}

/**
 *	@brief	Remove the repetive strings from a mutale array.
 *
 *	@param 	array 	The array from which you want to remove.
 */
+ (void)removeRepetiveStringFromArray:(NSMutableArray *)array {
    NSString *tmpLastStr = nil;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < array.count; i++) {
        NSString *str = [array objectAtIndex:i];
        if ([str isEqualToString:tmpLastStr]) {
            [indexSet addIndex:i];
        }
        tmpLastStr = str;
    }
    [array removeObjectsAtIndexes:indexSet];
}

/**
 *	@brief	根据文件名称和文件类型返回文件在bundle中的路径
 *
 *	@param 	fileName 	文件名称
 *	@param 	fileType 	文件类型
 *
 *	@return	文件在bundle中的路径
 */
+ (NSString *)pathFromBundleWithFileName:(NSString *)fileName fileType:(NSString *)fileType {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    return path;
}

@end
