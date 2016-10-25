//
//

#import "BasicMainNC.h"

#import "LoginViewController.h"
@interface BasicMainNC ()



@end

@implementation BasicMainNC
+(void)initialize{
     [self setItems];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged:) name:LoginStatus_Changed object:nil];
    
   
    
}
+(void)setItems
{    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:kWhiteColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
//    UIImage *backItemImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonBackgroundImage:backItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>=1)
    {
        UIButton *backbutton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        [backbutton setImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
        
        [backbutton setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        
        [backbutton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:backbutton];
        
        [viewController.navigationItem setLeftBarButtonItem:leftItem];
        
//        [viewController setHidesBottomBarWhenPushed:YES];
//        viewController.tabBarController.tabBar.hidden=YES;
    }else{
//       viewController.tabBarController.tabBar.hidden=NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}
-(void)backAction:(id)sender
{
    [self popViewControllerAnimated:YES];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)loginStatusChanged:(NSNotification *)notifi
{
        LoginViewController *vc=[LoginViewController new];
        BasicMainNC *loginNav=[[BasicMainNC alloc] initWithRootViewController:vc];
                               
       [self presentViewController:loginNav animated:YES completion:nil ];
        
        
        
}
    -(UIStatusBarStyle)preferredStatusBarStyle{
        return UIStatusBarStyleLightContent;
    }
    
    //设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    NSLog(@"statusBar.backgroundColor--->%@",statusBar.backgroundColor);
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
    -(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        
        //设置导航条透明度
        self.navigationController.navigationBar.translucent = NO;//不透明
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        //图标颜色为黑色
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        //导航栏背景颜色
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        //导航条下面的黑线
        self.navigationController.navigationBar.clipsToBounds = NO;
        
        //刷新状态栏背景颜色
        // [self setNeedsStatusBarAppearanceUpdate];
        
        //设置状态栏颜色
        [self setStatusBarBackgroundColor:base_control_color];
    }
    
    - (void)viewWillDisappear:(BOOL)animated{
        [super viewWillDisappear:animated];
        //为了不影响其他页面在viewDidDisappear做以下设置
//        self.navigationController.navigationBar.translucent = YES;//透明
//        [self setStatusBarBackgroundColor:[UIColor clearColor]];
    }
    
    
@end
