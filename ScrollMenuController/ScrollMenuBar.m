//
//  ScrollMenuBar.m
//  ScrollMenuController
//
//  Created by Bastian Kohlbauer on 23.06.13.
//  Copyright (c) 2013 Bastian Kohlbauer. All rights reserved.
//

#import "ScrollMenuBar.h"

@implementation ScrollMenuBar

@synthesize delegate;
@synthesize scrollView, pageControl;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

-(void)setMenuArray:(NSArray*)array {
    
    menuArray = [NSArray arrayWithArray:array];
    
    numberOfScrollViewPages = [menuArray count];
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [menuArray count]; i++) {
        [controllers addObject:[NSNull null]];
    }
    viewControllers = controllers;
    
    scrollView = [[UIScrollView alloc]initWithFrame: CGRectMake((self.frame.size.width/3), 0, (self.frame.size.width/3), self.frame.size.height-15)];
    scrollView.contentSize = CGSizeMake(((self.frame.size.width/3) * numberOfScrollViewPages), self.frame.size.height-15);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.clipsToBounds = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-15, self.frame.size.width, 15)];
    [pageControl setUserInteractionEnabled:FALSE];
    pageControl.numberOfPages = numberOfScrollViewPages;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return scrollView;
    }
    return nil;
}

- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= numberOfScrollViewPages) return;
    
    // replace the placeholder if necessary
    UIViewController *controller = [viewControllers objectAtIndex:page];
    
    if ((NSNull *)controller == [NSNull null]) {
        
        controller = [[UIViewController alloc] init];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
        
        for (int i = 0; i < numberOfScrollViewPages; i++) {
            
            if (page == i) {
                
                UILabel *menuLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, controller.view.frame.size.width-20, controller.view.frame.size.height-10)];
                [menuLabel setBackgroundColor:[UIColor lightGrayColor]];
                [menuLabel setTextAlignment:NSTextAlignmentCenter];
                [menuLabel setFont:[UIFont boldSystemFontOfSize:20]];
                [menuLabel setAdjustsFontSizeToFitWidth:YES];
                [menuLabel setTextColor:[UIColor whiteColor]];
                [menuLabel setText:[menuArray objectAtIndex:i]];
                menuLabel.tag = i;
                [controller.view addSubview:menuLabel];
                
                if (page != pageControl.currentPage) {
                    menuLabel.alpha = 0.5;
                }else{
                    menuLabel.alpha = 1.0;
                }
                
            }
            
        }
        
    }
    
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = page;
    
    [self.delegate scrollMenu:self didScrollToIndex:page];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    if(self.scrollView.isTracking){
        //do something
        
        for (UIView *view in self.scrollView.subviews) {
            
            for (UILabel *label in view.subviews) {
                
                if (label.tag == page) {
                    
                    label.alpha = 1.0;
                    
                }else{
                    
                    label.alpha = 0.5;
                    
                }
            }
            
        }
    }
        
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollVieww {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    for (UIView *view in self.scrollView.subviews) {
        
        for (UILabel *label in view.subviews) {
            
            if (label.tag == page) {
                
                label.alpha = 1.0;
                
            }else{
                
                label.alpha = 0.5;
                
                
            }
        }
        
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
