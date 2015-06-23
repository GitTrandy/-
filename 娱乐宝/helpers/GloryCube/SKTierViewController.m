//
//  SKTierViewController.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKTierViewController.h"

@interface SKTierViewController ()

@property (nonatomic, assign) CGRect leftControllerViewFrame;

@end

@implementation SKTierViewController
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_centerController release]; // 必须
    [_leftController release]; // 可选
    [_rightController release]; // 可选
    [_topController release]; // 可选
    [_bottomController release]; // 可选
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    [SKUtil forceLandscape];
    
    self.view.frame = _contentRect;
    
    [self _initView];
}

//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

//#else

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

//#endif

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Public Methods
- (id)initWithCenterController:(UIViewController *)centerController contentRect:(CGRect)contentRect {
    self = [super init];
    if (self) {
        self.contentRect = contentRect;
        self.centerController = centerController;
    }
    return self;
}

- (void)showLeftControllerWithRatio:(CGFloat)ratio duration:(CGFloat)duration bounceDuration:(CGFloat)bounceDuration animate:(BOOL)animate bounce:(BOOL)bounce  completion:(void (^)(BOOL finished))completion {
    if (_leftController) {
        UIView *v = _leftController.view;
        CGRect endRect = CGRectMake(-_contentRect.size.width * (1 - ratio), v.frame.origin.y, v.frame.size.width, v.frame.size.height);
        self.leftControllerViewFrame = endRect;
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.width * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.x += distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showBottomControllerWithRatio:(CGFloat)ratio
                                duration:(CGFloat)duration
                          bounceDuration:(CGFloat)bounceDuration
                                 animate:(BOOL)animate
                                  bounce:(BOOL)bounce
                              completion:(void (^)(BOOL finished))completion {
    if (_bottomController) {
        UIView *v = _bottomController.view;
        CGRect endRect = CGRectMake(v.frame.origin.x, _contentRect.size.height * (1 - ratio), v.frame.size.width, v.frame.size.height);
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.height * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.y -= distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showRightControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion {
    if (_rightController) {
        UIView *v = _rightController.view;
        CGRect endRect = CGRectMake(_contentRect.size.width * (1 - ratio), v.frame.origin.y, v.frame.size.width, v.frame.size.height);
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.width * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.x -= distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showTopControllerWithRatio:(CGFloat)ratio
                          duration:(CGFloat)duration
                    bounceDuration:(CGFloat)bounceDuration
                           animate:(BOOL)animate
                            bounce:(BOOL)bounce
                        completion:(void (^)(BOOL finished))completion {
    if (_topController) {
        UIView *v = _topController.view;
        CGRect endRect = CGRectMake(v.frame.origin.x, -_contentRect.size.height * (1 - ratio), v.frame.size.width, v.frame.size.height);
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.height * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.y += distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)setCenterController:(UIViewController *)centerController {
    if (_centerController != centerController) {
        [_centerController.view removeFromSuperview];
        [_centerController release];
        _centerController = [centerController retain];
        [_centerController.view setFrame:_contentRect];
    }
}

- (void)setLeftController:(UIViewController *)leftController {
    if (_leftController != leftController) {
        [_leftController.view removeFromSuperview];
        [_leftController release];
        _leftController = [leftController retain];
        CGRect frame = _contentRect;
        frame.origin.x = -_contentRect.size.width;
        [_leftController.view setFrame:frame];
    }
}

- (void)setRightController:(UIViewController *)rightController {
    if (_rightController != rightController) {
        [_rightController.view removeFromSuperview];
        [_rightController release];
        _rightController = [rightController retain];
        CGRect frame = _contentRect;
        frame.origin.x = _contentRect.size.width;
        [_rightController.view setFrame:frame];
    }
}

- (void)setTopController:(UIViewController *)topController {
    if (_topController != topController) {
        [_topController.view removeFromSuperview];
        [_topController release];
        _topController = [topController retain];
        CGRect frame = _contentRect;
        frame.origin.y = -_contentRect.size.height;
        [_topController.view setFrame:frame];
    }
}

- (void)setBottomController:(UIViewController *)bottomController {
    if (_bottomController != bottomController) {
        [_bottomController.view removeFromSuperview];
        [_bottomController release];
        _bottomController = [bottomController retain];
        CGRect frame = _contentRect;
        frame.origin.y = _contentRect.size.height;
        [_bottomController.view setFrame:frame];
    }
}

- (void)showLeftControllerWithRatio:(CGFloat)ratio
                           duration:(CGFloat)duration
                     bounceDuration:(CGFloat)bounceDuration
                        contentSize:(CGSize)size
                            animate:(BOOL)animate
                             bounce:(BOOL)bounce
                         completion:(void (^)(BOOL finished))completion {
    if (_leftController) {
        UIView *v = _leftController.view;
        CGRect endRect = CGRectMake(-_contentRect.size.width * (1 - ratio), v.frame.origin.y, size.width, size.height);
        self.leftControllerViewFrame = endRect;
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.width * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.x += distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showRightControllerWithRatio:(CGFloat)ratio
                            duration:(CGFloat)duration
                      bounceDuration:(CGFloat)bounceDuration
                         contentSize:(CGSize)size
                             animate:(BOOL)animate
                              bounce:(BOOL)bounce
                          completion:(void (^)(BOOL finished))completion {
    if (_rightController) {
        UIView *v = _rightController.view;
        CGRect endRect = CGRectMake(_contentRect.size.width * (1 - ratio), v.frame.origin.y, size.width, size.height);
//        CGRect endRect = _rightController.view.frame;
//        endRect.origin.x = _contentRect.size.width * (1 - ratio);
//        endRect.size.width = size.width;
//        endRect.size.height = size.height;
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.width * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.x -= distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showTopControllerWithRatio:(CGFloat)ratio
                          duration:(CGFloat)duration
                    bounceDuration:(CGFloat)bounceDuration
                       contentSize:(CGSize)size
                           animate:(BOOL)animate
                            bounce:(BOOL)bounce
                        completion:(void (^)(BOOL finished))completion {
    if (_topController) {
        UIView *v = _topController.view;
        CGRect endRect = CGRectMake(v.frame.origin.x, -_contentRect.size.height * (1 - ratio), size.width, size.height);
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.height * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.y += distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

- (void)showBottomControllerWithRatio:(CGFloat)ratio
                             duration:(CGFloat)duration
                       bounceDuration:(CGFloat)bounceDuration
                          contentSize:(CGSize)size
                              animate:(BOOL)animate
                               bounce:(BOOL)bounce
                           completion:(void (^)(BOOL finished))completion {
    if (_bottomController) {
        UIView *v = _bottomController.view;
        CGRect endRect = CGRectMake(v.frame.origin.x, _contentRect.size.height * (1 - ratio), size.width, size.height);
        
        // 弹性的距离
        CGFloat distance = 33.0f / _contentRect.size.width * _contentRect.size.height * ratio;
        
        [self.view addSubview:v];
        
        if (animate) {
            [UIView animateWithDuration:duration delay:0.0f options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionLayoutSubviews) animations:^{
                v.frame = endRect;
            } completion:^(BOOL finished) {
                if (bounce) {
                    [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseOut) animations:^{
                        CGRect rect = endRect;
                        rect.origin.y -= distance;
                        v.frame = rect;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:bounceDuration delay:0.0f options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                            v.frame = endRect;
                        } completion:completion];
                    }];
                } else if (completion) {
                    completion(YES);
                }
            }];
        } else {
            v.frame = endRect;
            if (completion) {
                completion(YES);
            }
        }
    }
}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
}

- (void)_initView {
    if (_centerController) {
        UIView *v = _centerController.view;
        /*
         下方一定不要设置_centerController.view的frame为CGRectMake(0, 0, 1024, 704)，
         这样设置之后，就会导致_centerController.view的下半部分不能交互。可能的原因是
         controller的加载视图的机制引起的，因为其实controller虽然是横屏，但是其实际上还是
         (0, 0, 748, 1024)，所以第一次加载视图的时候，一定有它自己的处理机制，不能设置
         _centerController.view的frame。但是可以做下面的设置。但是如果我们在本类的
         viewDidLoad方法中设置了本类的view的frame的话，就可以设置centerController.view
         的frame了。如果没有在本类的viewDidLoad方法中设置本类view的frame的话，就不能设置
         centerController.view的frame。
         */
//        v.frame = _centerController.view.bounds;
        [self.view addSubview:v];
    }
}

//// 添加pan手势到 view 上
//- (void)_addPanGestureToView:(UIView *)view {
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
////    panGesture.delegate = self;
//    panGesture.maximumNumberOfTouches = 1;
//    panGesture.minimumNumberOfTouches = 1;
//    [view addGestureRecognizer:panGesture];
//}

//- (void)_handlePan:(UIPanGestureRecognizer *)gesture {
//    CGPoint translate = [gesture translationInView:self.view];
//    SKLog(@"translate: %@", NSStringFromCGPoint(translate));
//    CGRect frame = _leftControllerViewFrame;
//    frame.origin.x += translate.x;
//    _leftController.view.frame = frame;
//    
//    if (gesture.state == UIGestureRecognizerStateEnded) {
//        if (fabsf(translate.x) < 200) {
//            [self showLeftControllerWithRatio:0.2 animate:YES bounce:YES completion:nil];
//        } else {
//            [self showLeftControllerWithRatio:0.8 animate:YES bounce:YES completion:nil];
//        }
//    }
//}

@end
