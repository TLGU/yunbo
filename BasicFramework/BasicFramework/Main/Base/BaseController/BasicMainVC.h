//
//

#import <UIKit/UIKit.h>

@interface BasicMainVC : UIViewController

@property(nonatomic,assign)CGFloat keyboarHeight;

@property(nonatomic,assign)BOOL backBarTextIsBack;

-(void)addNotifications;
- (void)removeKeyboardNotification;

-(void)keyboardDidShow:(NSNotification *)aNotification;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;

///生命周期VC行为
- (void)pop;
    
- (void)popToRootVc;
    
- (void)popToVc:(UIViewController *)vc;
    
- (void)dismiss;
    
- (void)dismissWithCompletion:(void(^)())completion;
    
- (void)presentVc:(UIViewController *)vc;
    
- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;
    
- (void)pushVc:(UIViewController *)vc;
    
- (void)removeChildVc:(UIViewController *)childVc;
    
- (void)addChildVc:(UIViewController *)childVc;
    
///加载动画
    /** 加载中*/
- (void)showLoadingAnimation;
    
    /** 停止加载*/
- (void)hideLoadingAnimation;
    
    /** 请求数据，交给子类去实现*/
- (void)loadData;
    
    @property (nonatomic, assign) BOOL isNetworkReachable;
    
@end
