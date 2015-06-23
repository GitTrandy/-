//
//  SKUtil.h
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NSObject (dictionary)

- (NSMutableDictionary *)getDictionary;

/**
 *	@brief	Set additional information to an object. The information is a key-value pair.
 *
 *	@param 	value 	The information.
 *	@param 	key 	The key.
 */
- (void)setAdditionalValue:(id)value forKey:(NSString *)key;

/**
 *	@brief	Get additional information from an object. The information is a key-value pair.
 *
 *	@param 	key 	The key.
 *
 *	@return	The information has been set before.
 */
- (id)additionalValueForKey:(NSString *)key;

@end

typedef NS_ENUM(NSInteger, SKExitApplicationAnimationStyle) {
    SKExitApplicationAnimationStyleFlipStyle1 = 1,
    SKExitApplicationAnimationStyleFlipStyle2,
    SKExitApplicationAnimationStyleCurlStyle1,
    SKExitApplicationAnimationStyleCurlStyle2
};

#define SKLocalizedString(key) \
    [SKUtil localizedStringWithKey:key]

@interface SKUtil : NSObject

/**
 *	@brief	a test method.
 */
+ (void)test;

/**
 *	@brief	get this the bundle object in this framework (Note: The bundle file named "SimpleKit.bundle" must include into your project).
 *
 *	@return	a framework bundle object.
 */
+ (NSBundle *)frameworkBundle;

/**
 *	@brief	Get the image object from this framework bundle.
 *
 *	@param 	name 	The name of image.
 *	@param 	type 	The type of image.
 *
 *	@return	An image object from this framework bundle.
 */
+ (UIImage *)imageFromBundleWithName:(NSString *)name ofType:(NSString *)type;

#pragma mark -
#pragma mark Border Code
/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 */
+ (void)borderWithView:(UIView *)view;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	masksToBounds 	Whether it should mask to bounds.
 */
+ (void)borderWithView:(UIView *)view masksToBounds:(BOOL)masksToBounds;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	color 	The color of the border.
 */
+ (void)borderWithView:(UIView *)view color:(UIColor *)color;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	color 	The color of the border.
 *	@param 	masksToBounds 	Whether it should mask to bounds.
 */
+ (void)borderWithView:(UIView *)view color:(UIColor *)color masksToBounds:(BOOL)masksToBounds;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	radius 	The corner radius of the border.
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	radius 	The corner radius of the border.
 *	@param 	masksToBounds 	Whether it should mask to bounds.
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius masksToBounds:(BOOL)masksToBounds;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	radius 	The corner radius of the border.
 *	@param 	color 	The color of the border.
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius color:(UIColor *)color;

/**
 *	@brief	Add a border to the view.
 *
 *	@param 	view 	The view object that should be added a border.
 *	@param 	radius 	The corner radius of the border.
 *	@param 	color 	The color of the border.
 *	@param 	masksToBounds 	Whether it should mask to bounds.
 */
+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius color:(UIColor *)color masksToBounds:(BOOL)masksToBounds;

#pragma mark -
#pragma mark WebView Code
/**
 *	@brief	Get the title string from a web page.
 *
 *	@param 	webView 	The web view object that displayed the web page.
 *
 *	@return	The title string.
 */
+ (NSString *)titleFromWebView:(UIWebView *)webView;

/**
 *	@brief	Execute the script codes at the web view, and return the result string.
 *
 *	@param 	script 	The script code.
 *	@param 	webView 	The web view object that executed the script codes.
 *
 *	@return	The result string by "return statement".
 */
+ (NSString *)executeScript:(NSString *)script atWebView:(UIWebView *)webView;

/**
 *	@brief	Clear the web session from the specified domain (Ex. 111.222.111.222 or www.google.com).
 *
 *	@param 	domain 	The domain information.
 */
+ (void)clearSessionWithDomain:(NSString *)domain;

#pragma mark -
#pragma mark Shared Info Code
/**
 *	@brief	Add the shared information to the device.
 *
 *	@param 	value 	The shared information to save.
 *	@param 	key 	The key.
 */
+ (void)addSharedInfoWithValue:(NSString *)value forKey:(NSString *)key;

/**
 *	@brief	Delete the shared information saved into the device.
 *
 *	@param 	key 	The key.
 */
+ (void)deleteSharedInfoWithKey:(NSString *)key;

/**
 *	@brief	Update the shared information saved into the device.
 *
 *	@param 	value 	The new value.
 *	@param 	key 	The key.
 */
+ (void)updateSharedInfoWithValue:(NSString *)value forKey:(NSString *)key;

/**
 *	@brief	Show all the shared information saved into the device.
 */
+ (void)showAllSharedInfo;

/**
 *	@brief	Search the shared information saved into the device.
 *
 *	@param 	key 	The key.
 *
 *	@return	The shared information that you want to see.
 */
+ (NSString *)searchSharedInfoValueWithKey:(NSString *)key;

/**
 *	@brief	Delete all the shared information saved into the device.
 */
+ (void)deleteAllSharedInfo;

#pragma mark -
#pragma mark Date Code
/**
 *	@brief	Get the date string from the date object. The date format likes "1999-09-12 12:12:12.121".
 *
 *	@param 	date 	The date object.
 *
 *	@return	The date string.
 */
+ (NSString *)stringWithDate:(NSDate *)date;

/**
 *	@brief	Get the date string from the date object with the specified format.
 *
 *	@param 	date 	The date object.
 *	@param 	dataFormat 	The date format (Ex: yyyy-MM-dd HH:mm:ss).
 *
 *	@return	The formatted date string.
 */
+ (NSString *)stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 *	@brief	Get the date object from the date string. The date format likes "1999-09-12 12:12:12.121".
 *
 *	@param 	dateString 	The date string.
 *
 *	@return	The date object.
 */
+ (NSDate *)dateWithString:(NSString *)dateString;

/**
 *	@brief	Get the date object from the date string.
 *
 *	@param 	dateString 	The date string.
 *	@param 	dateFormat 	The date format (Ex: yyyy-MM-dd HH:mm:ss).
 *
 *	@return	The date object.
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

#pragma mark -
#pragma mark Saved Info Code
/*
 根据 key值 从存储信息中取出 对象值
 */
/**
 *	@brief	Get the object from saved informations with the key value.
 *
 *	@param 	key 	The key.
 *
 *	@return	The object corresponded to the key value.
 */
+ (NSObject *)objectFromSavedInfoWithKey:(NSString *)key;

/**
 *	@brief	Save the object to the saved informations with the key value.
 *
 *	@param 	object 	The object to save.
 *	@param 	key 	The key.
 */
+ (void)saveToSavedInfoWithObject:(NSObject *)object andKey:(NSString *)key;

#pragma mark -
#pragma mark Image Code
/**
 *	@brief	Transform the normal image into the grayscale image.
 *
 *	@param 	image 	The normal image.
 *
 *	@return	The grayscale image.
 */
+ (UIImage *)grayscaleImageWithImage:(UIImage *)image;

#pragma mark -
#pragma mark System Code
/**
 *	@brief	Set the application to landscape mode.
 */
+ (void)forceLandscape;

/**
 *	@brief	Get the float value of the system version.
 *
 *	@return	The system version value.
 */
+ (CGFloat)floatValueOfCurrentDeviceVersion;

/**
 *	@brief	Capture the application operation exception.
 */
+ (void)caughtException;

/**
 *	@brief	set the app should disable autolock the screen
 *
 *	@param 	autoLock 	If YES, the app should disable autolock the screen; NO, not disable.
 */
+ (void)applicationShouldDisableAutolockScreen:(BOOL)autoLock;

/**
 *	@brief	exit the current running application, and you can specify the animation style
 *
 *	@param 	animated 	If YES, should use animation; NO, not animated.
 *  @param 	duration 	animation duration.
 *	@param 	animationStyle 	animation style 
 */
+ (void)exitApplication:(BOOL)animated duration:(CGFloat)duration options:(SKExitApplicationAnimationStyle)animationStyle;

/**
 *	@brief	exit the current running application, and you can specify the animation style
 *
 *	@param 	animated 	If YES, should use animation; NO, not animated.
 *  @param 	duration 	animation duration.
 *	@param 	animationStyle 	animation style
 *	@param 	delay 	the after delay time for exiting app
 */
+ (void)exitApplication:(BOOL)animated duration:(CGFloat)duration options:(SKExitApplicationAnimationStyle)animationStyle afterDelay:(CGFloat)delay;

/**
 *	@brief	Get the function point with the code block.
 *
 *	@param 	code 	The code block.
 *
 *	@return	The function point.
 */
+ (id)functionPointWithCode:(id)code;

#pragma mark -
#pragma mark UI Code
/**
 *	@brief	Add left bar button to the top of the navigation controller.
 *
 *	@param 	title 	title
 *	@param 	target 	target
 *	@param 	action 	action
 *	@param 	controller 	controller
 */
+ (void)addLeftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action toController:(UIViewController *)controller;

/**
 *	@brief	Add right bar button to the top of the navigation controller.
 *
 *	@param 	title 	title
 *	@param 	target 	target
 *	@param 	action 	action
 *	@param 	controller 	controller
 */
+ (void)addRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action toController:(UIViewController *)controller;

/**
 *	@brief	Present the modal controller from the base controller.
 *
 *	@param 	controller 	controller
 *	@param 	fromController 	fromController
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController;

/**
 *	@brief	Present the modal controller from the base controller.
 *
 *	@param 	controller 	controller description
 *	@param 	fromController 	fromController description
 *	@param 	transitionStyle 	transitionStyle description
 *	@param 	presentationStyle 	presentationStyle description
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController transitionStyle:(UIModalTransitionStyle)transitionStyle presentationStyle:(UIModalPresentationStyle)presentationStyle;

/**
 *	@brief	Present the modal controller from the base controller.
 *
 *	@param 	controller 	controller description
 *	@param 	fromController 	fromController description
 *	@param 	transitionStyle 	transitionStyle description
 *	@param 	presentationStyle 	presentationStyle description
 *	@param 	size 	size description
 *	@param 	center 	center description
 */
+ (void)presentController:(UIViewController *)controller fromController:(UIViewController *)fromController modalTransitionStyle:(UIModalTransitionStyle)transitionStyle modalPresentationStyle:(UIModalPresentationStyle)presentationStyle contentSize:(CGSize)size contentCenter:(CGPoint)center;

/**
 *	@brief	Dismiss the modal controller.
 *
 *	@param 	controller 	The modal controller.
 *	@param 	animated 	Whether it should animate.
 */
+ (void)dismissViewController:(UIViewController *)controller animated:(BOOL)animated;

/**
 *	@brief	Present the popover controller from the view.
 *
 *	@param 	popController 	The popover controller object. Note: The popover controller must be a "retain" property the class object which belongs to. 
 *	@param 	fromView 	The view which the arrow points to.
 *	@param 	inView 	The view to show the popover controller.
 *	@param 	size 	The size of the popover controlelr.
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size;

/**
 *	@brief	Present the popover controller from the view.
 *
 *	@param 	popController 	The popover controller object. Note: The popover controller must be a "retain" property the class object which belongs to. 
 *	@param 	fromView 	The view which the arrow points to.
 *	@param 	inView 	The view to show the popover controller.
 *	@param 	size 	The size of the popover controlelr.
 *	@param 	directions 	The arrow ditection.
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size arrowDirections:(UIPopoverArrowDirection)directions;

/**
 *	@brief	Present the popover controller from the view.
 *
 *	@param 	popController 	The popover controller object. Note: The popover controller must be a "retain" property the class object which belongs to. 
 *	@param 	fromView 	The view which the arrow points to.
 *	@param 	inView 	The view to show the popover controller.
 *	@param 	size 	The size of the popover controller.
 *	@param 	offset 	The offset of the popover controller.
 *	@param 	directions 	The arrow ditection.
 */
+ (void)presentPopoverController:(UIPopoverController *)popController fromView:(UIView *)fromView inView:(UIView *)inView popoverContentSize:(CGSize)size popoverContentOffset:(CGPoint)offset arrowDirections:(UIPopoverArrowDirection)directions;

/**
 *	@brief	Switch the base interface in the window.
 *
 *	@param 	controller 	The controller which you want to switch to.
 *	@param 	duration 	The duration of the animation.
 *	@param 	options 	The options of the animation.
 */
+ (void)switchViewWithController:(UIViewController *)controller duration:(CGFloat)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion;

/**
 *	@brief	Switch the base interface in the window.
 *
 *	@param 	controller 	The controller which you want to switch to.
 *	@param 	window      The window which includes the controller.
 *	@param 	duration 	The duration of the animation.
 *	@param 	options 	The options of the animation.
 */
+ (void)switchViewWithController:(UIViewController *)controller inWindow:(UIWindow *)window duration:(CGFloat)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion;

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
+ (UIImageView *)animatedImageViewWithFrame:(CGRect)frame duration:(CGFloat)duration images:(NSArray *)images repeatCount:(NSInteger)repeatCount;

/**
 *	@brief	Judge whether the textField's text is null.
 *
 *	@param 	textField 	The text field.
 *
 *	@return	If YES, the textField's text is null; NO, not null.
 */
+ (BOOL)isNullWithTextField:(UITextField *)textField;

#pragma mark -
#pragma mark Color Code
/**
 *	@brief	Get the color object from the hex color code (Ex: #RGB、#ARGB、#RRGGBB、#AARRGGBB).
 *
 *	@param 	hexString 	The hex color code.
 *
 *	@return	The color object.
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexString;

#pragma mark -
#pragma mark String Code
/**
 *	@brief	Judge whether the base string contains the given string.
 *
 *	@param 	findString 	The given string.
 *	@param 	fromString 	The base string.
 *
 *	@return	If YES, contains; NO, not contains.
 */
+ (BOOL)containString:(NSString *)findString fromString:(NSString *)fromString;

/**
 *	@brief	Get the localized string for multi-language environment with the key string.
 *
 *	@param 	key 	The key string.
 *
 *	@return	The localized string
 */
+ (NSString *)localizedStringWithKey:(NSString *)key;

/**
 *	@brief	Judge whether the base string contains the given string in a array. As long as the base string contains one of the array, the function will return YES.
 *
 *	@param 	findStrings 	The array of given strings that you want to find from base string.
 *	@param 	fromString 	The base string.
 *
 *	@return	If YES, contains; NO, not contains.
 */
+ (BOOL)containStrings:(NSArray *)findStrings fromString:(NSString *)fromString;

/**
 *	@brief	Remove the repetive strings from a mutale array.
 *
 *	@param 	array 	The array from which you want to remove.
 */
+ (void)removeRepetiveStringFromArray:(NSMutableArray *)array;

/**
 *	@brief	Get the file path in the main bundle with file name and file type.
 *
 *	@param 	fileName 	The file name.
  *	@param 	fileType 	The file type.
 *
 *	@return	The file path.
 */
+ (NSString *)pathFromBundleWithFileName:(NSString *)fileName fileType:(NSString *)fileType;

@end
