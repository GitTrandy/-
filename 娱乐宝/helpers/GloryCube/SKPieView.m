//
//  SKPieView.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKPieView.h"

@interface SKPieView ()

@property (nonatomic, assign) NSInteger numberOfSectors;
@property (nonatomic, retain) NSMutableArray *valueArray;
@property (nonatomic, retain) NSMutableArray *colorArray;
@property (nonatomic, retain) NSMutableArray *percentageTextArray;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *leftLabelPointArray;
@property (nonatomic, retain) NSMutableArray *leftSectorPointArray;

@end

@implementation SKPieView
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_valueArray release];
    [_colorArray release];
    [_percentageTextArray release];
    [_titleArray release];
    [_leftLabelPointArray release];
    [_leftSectorPointArray release];
    [_percentageFont release];
    [_titleFont release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    self.numberOfSectors = [_dataSource numberOfSectorsInPieView:self];
    
    CGFloat margin = 15;
    CGFloat strokeWidth = 1;
    
    if (_pieDiameter == 0) {
        self.pieDiameter = rect.size.height - margin * 2;
    }
    // 饼图圆所在矩形区域的左上角x和y坐标
    CGFloat x = (rect.size.width - _pieDiameter) / 2;
    CGFloat y = (rect.size.height - _pieDiameter) / 2;
    CGFloat radius = _pieDiameter / 2; // 饼图圆的半径
    CGFloat origin_x = floorf(x + _pieDiameter / 2); // 饼图圆原点的x值
    CGFloat origin_y = floorf(y + _pieDiameter / 2); // 饼图圆原点的y值
    CGFloat max_text_width = x - 10; // 文本显示的最大允许宽度
    
    if (_numberOfSectors != 0) {
        CGFloat total = 0;
        for (int i = 0; i < _numberOfSectors; i++) {
            CGFloat value = [_dataSource pieView:self valueForSectorIndex:i];
            [_valueArray addObject:[NSNumber numberWithFloat:value]];
            total += value;
            
            UIColor *fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            if ([_dataSource respondsToSelector:@selector(pieView:colorForSectorIndex:)]) {
                fillColor = [_dataSource pieView:self colorForSectorIndex:i];
            }
            [_colorArray addObject:fillColor];
        }
        
        for (int i = 0; i < _numberOfSectors; i++) {
            CGFloat value = [[_valueArray objectAtIndex:i] floatValue];
            NSString *percentage = [NSString stringWithFormat:@"%.1f%%", value / total * 100];
            [_percentageTextArray addObject:percentage];
            NSString *title = [_dataSource pieView:self titleForSectorIndex:i];
            [_titleArray addObject:title];
        }
        
        CGFloat labelHeight = 0;
        for (int i = 0; i < _numberOfSectors - 1; i++) { // 为什么是_numberOfSectors - 1，是因为如果是4个扇形的话，右边做多只能有3个扇形，剩下一个一定在左边
            NSString *percentage = [_percentageTextArray objectAtIndex:i];
            CGSize percentagteSize = [percentage sizeWithFont:_percentageFont constrainedToSize:CGSizeMake(max_text_width, 100)];
            CGFloat percentageHeight = percentagteSize.height;
            
            NSString *title = [_titleArray objectAtIndex:i];
            CGSize titleSize = [title sizeWithFont:_titleFont constrainedToSize:CGSizeMake(max_text_width, 100)];
            CGFloat titleHeight = titleSize.height;
            
            labelHeight += (percentageHeight + titleHeight);
        }
        
        CGFloat totalLabelHeight = rect.size.height - margin * 2;
        CGFloat labelGap = 0; // 饼图左右两边文本标签之间的间隔（百分比和标题是一组，算一个文本标签）
        if (_numberOfSectors >= 2) {
            labelGap = (totalLabelHeight - labelHeight) / (_numberOfSectors - 2);
        }
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
		UIGraphicsPushContext(ctx);
		CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f);  // white color
		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), margin);
		CGContextFillEllipseInRect(ctx, CGRectMake(x, y, self.pieDiameter, self.pieDiameter));  // a white filled circle with a diameter of 100 pixels, centered in (60, 60)
		UIGraphicsPopContext();
		CGContextSetShadow(ctx, CGSizeMake(0.0f, 0.0f), 0);
        
        CGFloat startDegree = 0;
        CGFloat endDegree = 0;
        CGFloat rightLableY = 15;
        CGFloat leftLabelY = 15;
        NSInteger rightLabelIndex = _numberOfSectors - 1;
        for (int i = 0; i < _numberOfSectors; i++) {
            CGFloat value = [[_valueArray objectAtIndex:i] floatValue];
            CGFloat percent = value / total;
            endDegree = startDegree + percent * 360;
            
            // 填充扇形区域
            UIColor *fillColor = [_colorArray objectAtIndex:i];
            CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
            CGContextMoveToPoint(ctx, origin_x, origin_y);
            CGContextAddArc(ctx, origin_x, origin_y, radius, (startDegree - 90) * M_PI / 180.0, (endDegree - 90) * M_PI / 180.0, 0);
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
            
            // 将扇形区域描白边
			CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
			CGContextSetLineWidth(ctx, strokeWidth);
            if (_numberOfSectors == 1) {
                CGContextSetLineWidth(ctx, 0);
            }
			CGContextMoveToPoint(ctx, origin_x, origin_y);
			CGContextAddArc(ctx, origin_x, origin_y, radius, (startDegree - 90) * M_PI / 180.0, (endDegree - 90) * M_PI / 180.0, 0);
			CGContextClosePath(ctx);
			CGContextStrokePath(ctx);
   
            startDegree = endDegree;
        }
        
        rightLableY = 15;
        leftLabelY = 15;
        startDegree = 0;
//        endDegree = 0;
        // 绘制箭头
        for (int i = 0; i < _numberOfSectors; i++) {
            CGFloat value = [[_valueArray objectAtIndex:i] floatValue];
            CGFloat percent = value / total;
            endDegree = startDegree + percent * 360;
            
            if (endDegree <= 180) { // 扇形区域在饼图圆的右方
                // 绘制百分比
                //                CGContextSetRGBFillColor(ctx, 0.1f, 0.1f, 0.1f, 1.0f);
                UIColor *fillColor = [_colorArray objectAtIndex:i];
                CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
                CGContextSetShadow(ctx, CGSizeMake(0, 0), 3);
                NSString *percentageText = [_percentageTextArray objectAtIndex:i];//[NSString stringWithFormat:@"%.1f%%", value / total * 100];
                CGSize optimumSize = [percentageText sizeWithFont:_percentageFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect percentageFrame = CGRectMake(floorf(x + _pieDiameter + 10), floorf(rightLableY), max_text_width, optimumSize.height);
                
                // 给百分比文字描边
                CGContextSaveGState(ctx);
                CGContextSetLineWidth(ctx, 1.0f);
                CGContextSetLineJoin(ctx, kCGLineJoinRound);
                CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
                //                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 0.8f);
                
                [percentageText drawInRect:percentageFrame withFont:_percentageFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
                CGContextRestoreGState(ctx);
                
                // 绘制箭头
                CGContextSaveGState(ctx);
                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 1);
                CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1);
                CGContextSetLineWidth(ctx, 1);
                
                int x1 = radius / 4 * 3 * cos((startDegree + value / total * 360 / 2 - 90) * M_PI / 180) + origin_x;
                int y1 = radius / 4 * 3 * sin((startDegree + value / total * 360 / 2 - 90) * M_PI / 180) + origin_y;
                
                CGContextMoveToPoint(ctx, floorf(x + _pieDiameter + 10 - 3), rightLableY + optimumSize.height / 2);
                if (_isBrokenLine) {
                    CGContextAddLineToPoint(ctx, x1, rightLableY + optimumSize.height / 2);
                }
                CGContextAddLineToPoint(ctx, x1, y1);
                CGContextStrokePath(ctx);
                CGContextRestoreGState(ctx);
                
                // 绘制标题文本
                NSString *title = [_titleArray objectAtIndex:i];//[_dataSource pieView:self titleForSectorIndex:i];
                //                CGContextSetRGBFillColor(ctx, 0.4f, 0.4f, 0.4f, 1.0f);
                CGContextSaveGState(ctx);
                CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
                CGContextSetAllowsFontSmoothing(ctx, YES);
                rightLableY += optimumSize.height;
                CGSize percentageSize = optimumSize;
                optimumSize = [title sizeWithFont:_titleFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect titleFrame = CGRectMake(floorf(x + _pieDiameter + 10), floorf(rightLableY), max_text_width, optimumSize.height);
                if (_titleAndPercentageAlign) {
                    titleFrame = CGRectMake(floorf(x + _pieDiameter + 10 + percentageSize.width + 10), floorf(rightLableY - percentageSize.height + (percentageSize.height - optimumSize.height) / 2), max_text_width - percentageSize.width - 10, optimumSize.height);
                }
                [title drawInRect:titleFrame withFont:_titleFont];
                CGContextRestoreGState(ctx);
                
                rightLableY += optimumSize.height + labelGap;
            } else if ((180 - startDegree) >= (endDegree - 180)) { // 扇形在饼图圆左右两侧，并且右侧部分较多
                // 绘制百分比
                //                CGContextSetRGBFillColor(ctx, 0.1f, 0.1f, 0.1f, 1.0f);
                UIColor *fillColor = [_colorArray objectAtIndex:i];
                CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
                CGContextSetShadow(ctx, CGSizeMake(0, 0), 3);
                NSString *percentageText = [_percentageTextArray objectAtIndex:i];//[NSString stringWithFormat:@"%.1f%%", value / total * 100];
                CGSize optimumSize = [percentageText sizeWithFont:_percentageFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect percentageFrame = CGRectMake(floorf(x + _pieDiameter + 10), floorf(rightLableY), max_text_width, optimumSize.height);
                
                // 给百分比文字描边
                CGContextSaveGState(ctx);
                CGContextSetLineWidth(ctx, 1.0f);
                CGContextSetLineJoin(ctx, kCGLineJoinRound);
                CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
                //                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 0.8f);
                
                [percentageText drawInRect:percentageFrame withFont:_percentageFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
                CGContextRestoreGState(ctx);
                
                // 绘制箭头
                CGContextSaveGState(ctx);
                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 1);
                CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1);
                CGContextSetLineWidth(ctx, 1);
                
                int x1 = radius / 4 * 3 * cos((startDegree + value / total * 360 / 2 - 90) * M_PI / 180) + origin_x;
                int y1 = radius / 4 * 3 * sin((startDegree + value / total * 360 / 2 - 90) * M_PI / 180) + origin_y;
                
                CGContextMoveToPoint(ctx, floorf(x + _pieDiameter + 10 - 3), rightLableY + optimumSize.height / 2);
                if (_isBrokenLine) {
                    CGContextAddLineToPoint(ctx, x1, rightLableY + optimumSize.height / 2);
                } else if (_numberOfSectors == 1) {
                    CGContextAddLineToPoint(ctx, x1, rightLableY + optimumSize.height / 2);
                }
                
                
                if (_numberOfSectors != 1) {
                    CGContextAddLineToPoint(ctx, x1, y1);
                }
                CGContextStrokePath(ctx);
                CGContextRestoreGState(ctx);
                
                // 绘制标题文本
                NSString *title = [_titleArray objectAtIndex:i];//[_dataSource pieView:self titleForSectorIndex:i];
                //                CGContextSetRGBFillColor(ctx, 0.4f, 0.4f, 0.4f, 1.0f);
                CGContextSaveGState(ctx);
                CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
                CGContextSetAllowsFontSmoothing(ctx, YES);
                rightLableY += optimumSize.height;
                CGSize percentageSize = optimumSize;
                optimumSize = [title sizeWithFont:_titleFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect titleFrame = CGRectMake(floorf(x + _pieDiameter + 10), floorf(rightLableY), max_text_width, optimumSize.height);
                if (_titleAndPercentageAlign) {
                    titleFrame = CGRectMake(floorf(x + _pieDiameter + 10 + percentageSize.width + 10), floorf(rightLableY - percentageSize.height + (percentageSize.height - optimumSize.height) / 2), max_text_width - percentageSize.width - 10, optimumSize.height);
                }

                [title drawInRect:titleFrame withFont:_titleFont];
                CGContextRestoreGState(ctx);
                
                rightLableY += optimumSize.height + labelGap;
            } else { // 饼图左边的扇形label
                // 绘制百分比
                //                CGContextSetRGBFillColor(ctx, 0.1f, 0.1f, 0.1f, 1.0f);
                UIColor *fillColor = [_colorArray objectAtIndex:rightLabelIndex];
//                value = [[_valueArray objectAtIndex:rightLabelIndex] floatValue];
                CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
                CGContextSetShadow(ctx, CGSizeMake(0, 0), 3);
                NSString *percentageText = [_percentageTextArray objectAtIndex:(rightLabelIndex)];//[NSString stringWithFormat:@"%.1f%%", value / total * 100];
                CGSize optimumSize = [percentageText sizeWithFont:_percentageFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect percentageFrame = CGRectMake(0, floorf(leftLabelY), max_text_width, optimumSize.height);
//                CGContextFillRect(ctx, percentageFrame);
                
                // 给百分比文字描边
                CGContextSaveGState(ctx);
                CGContextSetLineWidth(ctx, 1.0f);
                CGContextSetLineJoin(ctx, kCGLineJoinRound);
                CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
//                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 0.8f);
                
                [percentageText drawInRect:percentageFrame withFont:_percentageFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                CGContextRestoreGState(ctx);
                
                // 绘制箭头
//                CGContextSaveGState(ctx);
//                CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 1);
//                CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1);
//                CGContextSetLineWidth(ctx, 1);
                
                int x1 = origin_x + radius / 4 * 3 * cos((startDegree + value / total * 360 / 2 - 90) * M_PI / 180);
                int y1 = origin_y + radius / 4 * 3 * sin((startDegree + value / total * 360 / 2 - 90) * M_PI / 180);
                
                CGPoint point = CGPointMake(x1, y1);
                [_leftSectorPointArray addObject:[NSValue valueWithCGPoint:point]];
                
//                SKLog(@"x1, y1, rightLabelIndex, leftLabelY, value: %d, %d, %d, %f, %f, %f, %f", x1, y1, rightLabelIndex, leftLabelY, value, radius / 4 * 3 * cos((startDegree + value / total * 360 / 2 - 90) * M_PI / 180), startDegree + value / total * 360 / 2);
                
                x1 = floorf(x - 10 + 3);
                y1 = leftLabelY + optimumSize.height / 2;
                point = CGPointMake(x1, y1);
                [_leftLabelPointArray addObject:[NSValue valueWithCGPoint:point]];
                
//                CGContextMoveToPoint(ctx, floorf(x - 10 + 3), leftLabelY + optimumSize.height / 2);
//                CGContextAddLineToPoint(ctx, x1, leftLabelY + optimumSize.height / 2);
//                CGContextAddLineToPoint(ctx, x1, y1);
//                CGContextStrokePath(ctx);
//                CGContextRestoreGState(ctx);
                
                // 绘制标题文本
                NSString *title = [_titleArray objectAtIndex:(rightLabelIndex)];//[_dataSource pieView:self titleForSectorIndex:i];
                //                CGContextSetRGBFillColor(ctx, 0.4f, 0.4f, 0.4f, 1.0f);
                CGContextSaveGState(ctx);
                CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
                CGContextSetAllowsFontSmoothing(ctx, YES);
                
                leftLabelY += optimumSize.height;
                CGSize percentageSize = optimumSize;
                optimumSize = [title sizeWithFont:_titleFont constrainedToSize:CGSizeMake(max_text_width, 100)];
                CGRect titleFrame = CGRectMake(5, floorf(leftLabelY), max_text_width, optimumSize.height);
                if (_titleAndPercentageAlign) {
                    titleFrame = CGRectMake(5, floorf(leftLabelY - percentageSize.height + (percentageSize.height - optimumSize.height) / 2), max_text_width - percentageSize.width - 10, optimumSize.height);
                }
                [title drawInRect:titleFrame withFont:_titleFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentRight];
                CGContextRestoreGState(ctx);
                
                leftLabelY += optimumSize.height + labelGap;
                rightLabelIndex--;
            }
            
            startDegree = endDegree;
        }
        
        // 绘制左边箭头，特殊问题处理
        for (int i = 0; i < [_leftLabelPointArray count]; i++) {
            CGContextSaveGState(ctx);
            CGContextSetRGBFillColor(ctx, 0.2f, 0.2f, 0.2f, 1);
            CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1);
            CGContextSetLineWidth(ctx, 1);
            
            CGPoint leftLabelPoint = [[_leftLabelPointArray objectAtIndex:i] CGPointValue];
            CGPoint leftSectorPoint = [[_leftSectorPointArray objectAtIndex:_leftSectorPointArray.count - 1 - i] CGPointValue];
            CGContextMoveToPoint(ctx, leftLabelPoint.x, leftLabelPoint.y);
            if (_isBrokenLine) {
                CGContextAddLineToPoint(ctx, leftSectorPoint.x, leftLabelPoint.y);
            }
            CGContextAddLineToPoint(ctx, leftSectorPoint.x, leftSectorPoint.y);
            CGContextStrokePath(ctx);
            
            CGContextRestoreGState(ctx);

        }
    }
}

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.valueArray = [NSMutableArray arrayWithCapacity:0];
    self.colorArray = [NSMutableArray arrayWithCapacity:0];
    self.percentageFont = [UIFont boldSystemFontOfSize:20];
    self.titleFont = [UIFont systemFontOfSize:14];
    self.percentageTextArray = [NSMutableArray arrayWithCapacity:0];
    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    self.leftLabelPointArray = [NSMutableArray arrayWithCapacity:0];
    self.leftSectorPointArray = [NSMutableArray arrayWithCapacity:0];
    self.isBrokenLine = YES;
}

- (void)_initView {
	// TODO: init view code
}

@end
