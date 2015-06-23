//
//  CustomTabBar.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/10.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarDelegate <NSObject>

- (void)selectViewControler:(NSInteger *)controller withIndex:(NSInteger *)index;


@end

@interface CustomTabBar : UIView

@property(nonatomic,assign)id<CustomTabBarDelegate>delegate;

//receive controllers
- (void)addViewControllers:(NSArray *)viewControllers withNormalImages:(NSArray *)normalImages andSelectedImages:(NSArray *)selectedImages;



@end
