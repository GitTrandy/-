//
//  SKWebViewController.h
//  SimpleKit
//
//  Created by SimpleKit on 12-6-25.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleKit.h"

@interface SKWebViewController : UIViewController 
<
SKWebToolBarItemDelegate,
UIWebViewDelegate
>

@property (nonatomic, retain) NSArray *urlDatas;
@property (nonatomic, assign) CGFloat segWidth;
@property (nonatomic, assign) BOOL isNeedRelogin;

@end
