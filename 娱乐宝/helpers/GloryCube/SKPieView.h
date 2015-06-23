//
//  SKPieView.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SKPieView;

@protocol SKPieViewDataSource <NSObject>

@required
- (NSInteger)numberOfSectorsInPieView:(SKPieView *)pieView;
- (CGFloat)pieView:(SKPieView *)pieView valueForSectorIndex:(NSInteger)sectorIndex;
- (NSString *)pieView:(SKPieView *)pieView titleForSectorIndex:(NSInteger)sectorIndex;

@optional
- (UIColor *)pieView:(SKPieView *)pieView colorForSectorIndex:(NSInteger)sectorIndex;

@end

@protocol SKPieViewDelegate <NSObject>

@end

@interface SKPieView : UIView

@property (nonatomic, assign) IBOutlet id<SKPieViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<SKPieViewDelegate> delegate;
@property (nonatomic, assign) NSInteger pieDiameter;
@property (nonatomic, retain) UIFont *percentageFont;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, assign) BOOL titleAndPercentageAlign;
@property (nonatomic, assign) BOOL isBrokenLine;

@end
