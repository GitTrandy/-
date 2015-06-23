//
//  SKScrollPageView.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKScrollPageView.h"

// PageControl的高度
static const int kPageControlHeight = 36;

@interface SKScrollPageView () <UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *pageViews;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL pageControlUsed;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger lastPage;

- (void)initAll;
- (void)loadScrollViewWithPage:(NSNumber *)pageNum;
- (void)clearInvisibleViewsWithPageIndex:(NSNumber *)indexNum;

@end

@implementation SKScrollPageView

#pragma mark -
#pragma mark Public Properties
@synthesize currentPage = _currentPage;

#pragma mark -
#pragma mark Private Properties

#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // Release code
    [_bgImage release];
    [_pageViews release];
    [_scrollView release];
    [_pageControl release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        // 在drawRect方式中不能设置背景颜色属性，因为drawRect执行时，前提就是在已经设置好的的背景颜色上绘制，默认情况下应该是透明色
        //[self setBackgroundColor:[UIColor redColor]];
        
        self.viewCacheParameter = 2;
    }
    return self;
}

//// 此方法会在布局视图时被调用
- (void)layoutSubviews {
    
    if ([self.subviews count] == 0) {
        [self initAll];
    }
    
    [super layoutSubviews];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    
//}

#pragma mark -
#pragma mark Public Methods
/*
 设置当前组件为 currentPage 页面，索引号从0开始
 */
- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    
    if (currentPage >= 0 && currentPage < _numberOfPages) {
        [_pageControl setCurrentPage:currentPage];
        
        NSNumber *pageNum = [NSNumber numberWithInt:currentPage];
        [self refreshPageViewsWithPage:pageNum];
        
        // update the scroll view to the appropriate page
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * [pageNum intValue];
        frame.origin.y = 0;
        [_scrollView scrollRectToVisible:frame animated:NO];
        
//        if ([_delegate respondsToSelector:@selector(scrollPageView:didChangePageAtIndex:)]) {
//            [_delegate scrollPageView:self didChangePageAtIndex:_currentPage];
//        }
    }
}

/*
 返回组件的当前 页面索引
 */
- (NSInteger)currentPage {
    return _pageControl.currentPage;
}

#pragma mark -
#pragma mark Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pageControlUsed) {
        return;
    }
    
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [_pageControl setCurrentPage:page];
    
    if (_lastPage != page) {
        [self refreshPageViewsWithPage:[NSNumber numberWithInt:page]];
        
        if ([_delegate respondsToSelector:@selector(scrollPageView:didChangePageAtIndex:)]) {
            [_delegate scrollPageView:self didChangePageAtIndex:page];
        }
    }
    
    _lastPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
    // 此句放在此处的目的是优先保证加载视图的方法先执行，然后再执行清楚掉不可见视图，但是有个问题：如果用户使劲左右滑动，可能导致内存崩掉
//    [self performSelectorInBackground:@selector(clearInvisibleViewsWithPageIndex:) withObject:[NSNumber numberWithInt:_lastPage]];
}

#pragma mark -
#pragma mark Private Methods
- (void)initAll {
    // 如果委托为空，则_numberOfPages为默认值 0
    if ([_delegate respondsToSelector:@selector(numberOfPagesInScrollPageView:)]) {
        _numberOfPages = [_delegate numberOfPagesInScrollPageView:self];
    }
    
    NSMutableArray *views = [[[NSMutableArray alloc] init] autorelease];
    for (unsigned i = 0; i < _numberOfPages; i++) {
        [views addObject:[NSNull null]];
    }
    self.pageViews = views;
    
	CGRect frame = self.frame;
    
    CGRect rect;
    
    rect = CGRectMake(0, 0, frame.size.width, frame.size.height - kPageControlHeight);
    self.scrollView = [[[UIScrollView alloc] initWithFrame:rect] autorelease];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(rect.size.width * _numberOfPages, rect.size.height)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setScrollsToTop:NO];
    [_scrollView setDelegate:self];
    [self insertSubview:_scrollView atIndex:0];
    
    if (_bgImage) {
        UIImageView *imgView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        [imgView setImage:_bgImage];
        [self insertSubview:imgView atIndex:0];
    }
    
    rect = CGRectMake(0, frame.size.height - kPageControlHeight, frame.size.width, kPageControlHeight);
    self.pageControl = [[[UIPageControl alloc] initWithFrame:rect] autorelease];
    [_pageControl setNumberOfPages:_numberOfPages];
    //[_pageControl setBackgroundColor:[UIColor blackColor]];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self insertSubview:_pageControl atIndex:1];
    //[SKScrollPageView borderWithView:_pageControl];
    
    [self loadScrollViewWithPage:[NSNumber numberWithInt:0]];
    [self loadScrollViewWithPage:[NSNumber numberWithInt:1]];
    //[self loadScrollViewWithPage:[NSNumber numberWithInt:2]];
    
    // 测试 setCurrentPage:方法
//    [self setCurrentPage:10];
    if ([_delegate respondsToSelector:@selector(didInitComponentsWithScrollPageView:)]) {
        [_delegate didInitComponentsWithScrollPageView:self];
    }
}

- (void)loadScrollViewWithPage:(NSNumber *)pageNum {
    @synchronized (self) {
        //[[NSThread currentThread] setThreadPriority:0.5];
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        int page = [pageNum intValue];
        
        if (page < 0) {
            [pool drain];
            return;
        }
        if (page >= _numberOfPages) {
            [pool drain];
            return;
        }
        
        UIView *view = [_pageViews objectAtIndex:page];
        if ((NSNull *)view == [NSNull null]) {
            if ([_delegate respondsToSelector:@selector(scrollPageView:viewForPageIndex:)]) {
                view = [_delegate scrollPageView:self viewForPageIndex:page];
                
                // 防止委托传过来nil
                if (view == nil) {
                    [pool drain];
                    return;
                }
                
                [view setBackgroundColor:[UIColor clearColor]];
                [view setUserInteractionEnabled:YES];
                [_pageViews replaceObjectAtIndex:page withObject:view];
                //NSLog(@"create view at %d", page);
            }
        }
        
        if ((NSNull *)view == [NSNull null] || view == nil) {
            [pool drain];
            return;
        }
        
        if (view.superview == nil) {
            // 可以在这里解决保持委托带来的视图的尺寸不变，只要将带过来的视图的frame的origin设置一下即可
            CGRect frame = _scrollView.frame;
            frame.origin.x = frame.size.width * page;
            frame.origin.y = 0;
            view.frame = frame;
            //[_scrollView addSubview:view];
            [_scrollView performSelectorOnMainThread:@selector(addSubview:) withObject:view waitUntilDone:[NSThread isMainThread]];
        }
        
        [pool drain];
    }
}

- (void)clearInvisibleViewsWithPageIndex:(NSNumber *)indexNum {
    @synchronized (self) {
        //[[NSThread currentThread] setThreadPriority:0.1];
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        int index = [indexNum intValue];
        
//        if (index - _viewCacheParameter < 0) {
//            return;
//        }
//        
//        if (index + _viewCacheParameter >= _numberOfPages) {
//            return;
//        }
        
        //<+ fanwei 20121231 解决迅速左右滑动UIScrollView，会出现报错，如导致EXC_BAD_ACCESS错误
        for (int i = 0; i <= index - _viewCacheParameter; i++) {
            UIView *view = [_pageViews objectAtIndex:i];
            if ((NSNull *)view != [NSNull null]) {
                // 防止view没有父视图时，执行removeFromSuperview导致EXC_BAD_ACCESS错误
                if (view != nil && [view superview] != nil) {
                    [view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:[NSThread isMainThread]];
                    [_pageViews replaceObjectAtIndex:i withObject:[NSNull null]];
                }
            }
        }

        for (int i = index + _viewCacheParameter; i < _numberOfPages; i++) {
            UIView *view = [_pageViews objectAtIndex:i];
            if ((NSNull *)view != [NSNull null]) {
                // 防止view没有父视图时，执行removeFromSuperview导致EXC_BAD_ACCESS错误
                if (view != nil && [view superview] != nil) {
                    [view performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:[NSThread isMainThread]];
                    [_pageViews replaceObjectAtIndex:i withObject:[NSNull null]];
                }
            }
        }
        //+>
        
        //    UIView *view = [_pageViews objectAtIndex:index - 2];
        //    if ((NSNull *)view != [NSNull null]) {
        //        // 防止view没有父视图时，执行removeFromSuperview导致EXC_BAD_ACCESS错误
        //        if ([view superview] != nil) {
        //            [view removeFromSuperview];
        //            [_pageViews replaceObjectAtIndex:index - 2 withObject:[NSNull null]];
        //        }
        //    }
        //
        //    view = [_pageViews objectAtIndex:index + 2];
        //    if ((NSNull *)view != [NSNull null]) {
        //        // 防止view没有父视图时，执行removeFromSuperview导致EXC_BAD_ACCESS错误
        //        if ([view superview] != nil) {
        //            [view removeFromSuperview];
        //            [_pageViews replaceObjectAtIndex:index + 2 withObject:[NSNull null]];
        //        }
        //    }
    
        [pool drain];
    }
}

- (void)refreshPageViewsWithPage:(NSNumber *)pageNum {
    @synchronized (self) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
//        NSRecursiveLock *recursiveLock = [[[NSRecursiveLock alloc] init] autorelease];
//        [recursiveLock lock];
        int page = [pageNum intValue];
        
        // 只能在主线程中更新UI，为了减少加载视图的时间延迟，我们分时间段加载视图，这样就不用连续加载视图，导致界面卡顿严重，我们总共时间段设置为 0.2 + 0.3 + 0.2 + 0.3 = 1 s，这样一来就减轻了卡顿的现象。
        [self performSelector:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(page - 1)] afterDelay:0.2];
        [self performSelector:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(page)] afterDelay:0.3];
        [self performSelector:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:(page + 1)] afterDelay:0.2];
        [self performSelector:@selector(clearInvisibleViewsWithPageIndex:) withObject:[NSNumber numberWithInt:page] afterDelay:0.3];
        
//        [self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:page - 1]];
//        [self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:page]];
//        [self performSelectorInBackground:@selector(loadScrollViewWithPage:) withObject:[NSNumber numberWithInt:page + 1]];
//        [self performSelectorInBackground:@selector(clearInvisibleViewsWithPageIndex:) withObject:pageNum];
        
        //[self clearInvisibleViewsWithPageIndex:pageNum];
        
//        [self loadScrollViewWithPage:[NSNumber numberWithInt:page - 1]];
//        [self loadScrollViewWithPage:[NSNumber numberWithInt:page]];
//        [self loadScrollViewWithPage:[NSNumber numberWithInt:page + 1]];
        
//        [self performSelectorOnMainThread:@selector(clearInvisibleViewsWithPageIndex:) withObject:[NSNumber numberWithInt:page] waitUntilDone:[NSThread isMainThread]];
        
//        [recursiveLock unlock];
        
        [pool drain];
    }
}

- (void)changePage:(id)sender {
    
    //NSLog(@"changePage");
    NSNumber *pageNum = [NSNumber numberWithInt:_pageControl.currentPage];
    
    if ([_delegate respondsToSelector:@selector(scrollPageView:didChangePageAtIndex:)]) {
        [_delegate scrollPageView:self didChangePageAtIndex:_pageControl.currentPage];
    }
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    
    [self refreshPageViewsWithPage:pageNum];
    
    // update the scroll view to the appropriate page
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * [pageNum intValue];
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:YES];
    
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    _pageControlUsed = YES;
}

/*
 给 view 添加边框
 */
+ (void)borderWithView:(UIView *)view {
    [[view layer] setShouldRasterize:YES];
	[[view layer] setBorderColor:[UIColor blueColor].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setMasksToBounds:YES];
	[[view layer] setCornerRadius:4];
}

+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius {
    [[view layer] setShouldRasterize:YES];
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setMasksToBounds:YES];
	[[view layer] setCornerRadius:radius];
    //NSLog(@">>> borderWithView");
}

@end
