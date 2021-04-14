//
//  BPControllerHooks.m
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPControllerHooks.h"
#import <Aspects/Aspects.h>
#import "BPViewControllerProtocol.h"

@implementation BPControllerHooks

+ (void)load{
    [super load];
    [BPControllerHooks sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BPControllerHooks *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
        [instance setupHooks];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)setupHooks{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        [self _viewDidLoad:aspectInfo.instance];
    } error:nil];
}

#pragma mark - Hook Methods
- (void)_viewDidLoad:(UIViewController <BPViewControllerProtocol>*)controller
{
    
    if ([controller conformsToProtocol:@protocol(BPViewControllerProtocol)]) {
        // 只有遵守 BPViewControllerProtocol 的 viewController 才进行 配置
        [controller mvvm_setupDefault];
        [controller mvvm_bindViewModelForController];
        [controller mvvm_setupNavigationItems];
        [controller mvvm_initSubViews];
    }
}

@end
