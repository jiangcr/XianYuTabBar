//
//  CustomTabBar.h
//  XianYuCustomTabBar
//
//  Created by jiang on 2017/3/9.
//  Copyright © 2017年 skydrui.regular. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

- (void)tabBar:(CustomTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

@end

@interface CustomTabBar : UIView

@property (nonatomic, weak)id <CustomTabBarDelegate>delegate;

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@end
