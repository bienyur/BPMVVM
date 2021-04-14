//
//  BPNavigationControllerStack.m
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPNavigationControllerStack.h"
#import <Aspects/Aspects.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "BPRouter.h"

@interface BPNavigationControllerStack ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id<BPViewModelServices> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;
@end

@implementation BPNavigationControllerStack

- (instancetype)initWithServices:(id<BPViewModelServices>)services {
    self = [super init];
    if (self) {
        self.services = services;
        [self registerNavigationHooks];
        self.navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)registerNavigationHooks {
    
    @weakify(self)
    
    // push view model
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(pushViewModel:animated:)]
     subscribeNext:^(RACTuple *tuple) {
        UIViewController *viewController = (UIViewController *)[BPRouter.sharedInstance viewControllerForViewModel:tuple.first];
        viewController.hidesBottomBarWhenPushed = YES;
        if (self.navigationControllers.count >0) {
            [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
        }else{
            [[self currentController].navigationController pushViewController:viewController animated:[tuple.second boolValue]]; 
        }
    }];
    
    // pop
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(popViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [[self currentController].navigationController popViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    // pop to root
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(popToRootViewModelAnimated:)]
     subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [[self currentController].navigationController popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    // preshent view model
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(presentViewModel:animated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        UIViewController *viewController = (UIViewController *)[BPRouter.sharedInstance viewControllerForViewModel:tuple.first];
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [[self currentController] presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    // dismiss
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)]
     subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        [[self currentController] dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
    // opne url in safari
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(applicationOpenURL:)]
     subscribeNext:^(RACTuple *tuple) {
        NSURL *url = tuple.first;
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            return;
        }
        if ([[UIDevice currentDevice] systemVersion].floatValue >= 10.0) {
            [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:url];
            });
        }
    }];
}

#pragma mark - private

/// 获取当前控制器
- (UIViewController*)currentController{
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

#pragma mark - public

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) return;
    navigationController.delegate = self;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}
- (void )removeNavigationControllers {
    [self.navigationControllers removeAllObjects];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (@available(iOS 11.0, *)) {
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    }
}


@end
