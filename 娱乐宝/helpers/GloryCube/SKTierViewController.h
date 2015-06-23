//
//  SKTierViewController.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTierViewController : UIViewController

@property (nonatomic, retain) UIViewController *centerController; // Must set the property.
@property (nonatomic, retain) UIViewController *leftController; // This is a optional property
@property (nonatomic, retain) UIViewController *rightController; // This is a optional property
@property (nonatomic, retain) UIViewController *topController; // This is a optional property
@property (nonatomic, retain) UIViewController *bottomController; // This is a optional property

@property (nonatomic, assign) CGRect contentRect; // The rect value of the moving view in the property controller. 

- (id)initWithCenterController:(UIViewController *)centerController contentRect:(CGRect)contentRect;

- (void)showLeftControllerWithRatio:(CGFloat)ratio
                              duration:(CGFloat)duration
                        bounceDuration:(CGFloat)bounceDuration
                               animate:(BOOL)animate
                                bounce:(BOOL)bounce
                            completion:(void (^)(BOOL finished))completion;

- (void)showBottomControllerWithRatio:(CGFloat)ratio
                              duration:(CGFloat)duration
                        bounceDuration:(CGFloat)bounceDuration
                               animate:(BOOL)animate
                                bounce:(BOOL)bounce
                            completion:(void (^)(BOOL finished))completion;

- (void)showRightControllerWithRatio:(CGFloat)ratio
                             duration:(CGFloat)duration
                       bounceDuration:(CGFloat)bounceDuration
                              animate:(BOOL)animate
                               bounce:(BOOL)bounce
                           completion:(void (^)(BOOL finished))completion;

- (void)showTopControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion;

- (void)showLeftControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                         contentSize:(CGSize)size
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion;

- (void)showRightControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                         contentSize:(CGSize)size
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion;

- (void)showTopControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                         contentSize:(CGSize)size
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion;

- (void)showBottomControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                         contentSize:(CGSize)size
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion;

@end
