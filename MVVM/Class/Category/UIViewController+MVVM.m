//
//  UIViewController+MVVM.m
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//

#import "UIViewController+MVVM.h"
#import <objc/runtime.h>

static const void *kViewModelKey = &kViewModelKey;

@implementation UIViewController (MVVM)

- (instancetype)initWithViewModel:(id<BPViewModelProtocol>)viewModel{
    self = [self init];
    if (self) {
        [self setViewModel:viewModel];
    }
    return self;
}

#pragma mark - 添加扩展参数

- (void)setViewModel:(id<BPViewModelProtocol> _Nonnull)viewModel{
    objc_setAssociatedObject(self, kViewModelKey, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<BPViewModelProtocol>)viewModel{
    return objc_getAssociatedObject(self, kViewModelKey);
}


@end
