//
//  SKAlertView.h
//  SimpleKit
//
//  Created by SimpleKit on 12-11-9.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKAlertView : UIAlertView

@property (assign, nonatomic) BOOL isAnimation;
@property (assign, nonatomic) NSInteger showTime; // The showing time of the alert. After the completion of the alert, it can automatically disappear.

@end
