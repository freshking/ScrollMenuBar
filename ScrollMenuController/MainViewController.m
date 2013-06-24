//
//  MainViewController.m
//  ScrollMenuController
//
//  Created by Bastian Kohlbauer on 23.06.13.
//  Copyright (c) 2013 Bastian Kohlbauer. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize menuBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    NSArray *menuItems = [NSArray arrayWithObjects:
                          @"Item0",
                          @"Item1",
                          @"Item2",
                          @"Item3",
                          @"Item4",
                          @"Item5",
                          @"Item6",
                          @"Item7",
                          @"Item8",
                          @"Item9", nil];

    menuBar = [[ScrollMenuBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    menuBar.backgroundColor = [UIColor darkGrayColor];
    menuBar.scrollView.backgroundColor = [UIColor clearColor];
    menuBar.pageControl.backgroundColor = [UIColor lightGrayColor];
    menuBar.delegate = self;
    [self.view addSubview:menuBar];
    
    [menuBar setMenuArray:menuItems];
    
    pageLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-75, (self.view.frame.size.height/2)+30, 150, 20)];
    [pageLabel setTextAlignment:NSTextAlignmentCenter];
    [pageLabel setText:@"Page: 0"];
    [self.view addSubview:pageLabel];
}

-(void)scrollMenu:(ScrollMenuBar *)scrollMenu didScrollToIndex:(NSUInteger)index {
    
   [pageLabel setText:[NSString stringWithFormat:@"Page: %i", index]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
