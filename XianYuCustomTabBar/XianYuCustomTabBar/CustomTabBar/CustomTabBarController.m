//
//  CustomTabBarController.m
//  XianYuCustomTabBar
//
//  Created by jiang on 2017/3/9.
//  Copyright © 2017年 skydrui.regular. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "FishpondViewController.h"
#import "PostViewController.h"
#import "MessageViewController.h"
#import "UserViewController.h"
#import "CustomTabBar.h"
@interface CustomTabBarController ()<CustomTabBarDelegate>

@property(nonatomic, strong)CustomTabBar *mainTabBar;

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SetupMainTabBar];
    [self SetupAllControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabBarBtn) name:@"removeTabBarBtn" object:nil];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    CustomTabBar *mainTabBar = [[CustomTabBar alloc] init];
    mainTabBar.frame = self.tabBar.bounds;
    mainTabBar.delegate = self;
    [self.tabBar addSubview:mainTabBar];
    _mainTabBar = mainTabBar;
//    
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    [self dropShadowWithOffset:CGSizeMake(0, -0.5) radius:1 color:[UIColor grayColor] opacity:0.3];
    
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页", @"鱼塘", @"消息", @"我的"];
    
    NSArray *images = @[@"home_normal", @"fishpond_normal", @"message_normal", @"account_normal"];
    
    NSArray *selectedImages = @[@"home_highlight", @"fishpond_highlight", @"message_highlight", @"account_highlight"];
    
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    
    FishpondViewController * subscriptionVc = [[FishpondViewController alloc] init];
    
    MessageViewController * notificationVc = [[MessageViewController alloc] init];
    
    UserViewController * meVc = [[UserViewController alloc] init];
    
    NSArray *viewControllers = @[homeVc, subscriptionVc, notificationVc, meVc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:childVc];
}

#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(CustomTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (self.view.window==nil) {
        self.view=nil;
    }
}


//tabBar顶部加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}


//返回根视图时移除原有的按钮
- (void)removeTabBarBtn
{
    for (UIView *tabBar in self.tabBar.subviews) {
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeTabBarBtn" object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
