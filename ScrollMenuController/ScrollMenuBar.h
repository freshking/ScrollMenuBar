//
//  ScrollMenuBar.h
//  ScrollMenuController
//
//  Created by Bastian Kohlbauer on 23.06.13.
//  Copyright (c) 2013 Bastian Kohlbauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollMenuBar;
@protocol ScrollMenuBarDelegate <NSObject>
@required
- (void)scrollMenu:(ScrollMenuBar*)scrollMenu didScrollToIndex:(NSUInteger) index;
@end

@interface ScrollMenuBar : UIView <UIScrollViewDelegate> {
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
    NSArray *menuArray;
    
    NSMutableArray *viewControllers;
    int numberOfScrollViewPages;
    
    id <ScrollMenuBarDelegate> delegate;
    
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, strong) id <ScrollMenuBarDelegate> delegate;

-(void)setMenuArray:(NSArray*)menuArray;

@end
