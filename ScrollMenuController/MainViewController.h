//
//  MainViewController.h
//  ScrollMenuController
//
//  Created by Bastian Kohlbauer on 23.06.13.
//  Copyright (c) 2013 Bastian Kohlbauer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollMenuBar.h"

@interface MainViewController : UIViewController <ScrollMenuBarDelegate>  {
    
    ScrollMenuBar *menuBar;
    
    UILabel *pageLabel;
}

@property (nonatomic, strong) ScrollMenuBar *menuBar;

@end
