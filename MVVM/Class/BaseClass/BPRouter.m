//
//  BPRouter.m
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPRouter.h"
#import "UIViewController+MVVM.h"

@interface BPRouter()
@property (nonatomic, strong,readwrite) NSDictionary *viewModelViewMappings;
@end

@implementation BPRouter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BPRouter *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

/// 通过view modeel 反射拿到 controller
- (UIViewController *)viewControllerForViewModel:(id<BPViewModelProtocol>)viewModel{
    NSString *viewController = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[UIViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
}

/// 配置router map 的 plist文件
- (NSDictionary *)viewModelViewMappings {
    if (!_viewModelViewMappings) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"router" ofType:@"plist"];
        _viewModelViewMappings = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _viewModelViewMappings;
}

@end
