//
//  NSObject+MVVM.m
//  MVVM_Example
//
//  Created by 404 on 2020/11/18.
//  Copyright © 2020 xuhongji. All rights reserved.
//

#import "NSObject+MVVM.h"

#import <objc/runtime.h>

static const void *kParamsKey = &kParamsKey;
static const void *kServicesKey = &kServicesKey;

@implementation NSObject (MVVM)

- (instancetype)initWithServices:(id<BPViewModelServices>)services params:(NSDictionary *)params{
    self = [self init];
    if (self) {
        [self setParams:params];
        [self setServices:services];
    }
    return self;
}

#pragma mark - 添加扩展参数
- (void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, kParamsKey, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, kParamsKey);
}

- (void)setServices:(id<BPViewModelServices> _Nonnull)services
{
    objc_setAssociatedObject(self, kServicesKey, services, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id<BPViewModelServices>)services{
    return objc_getAssociatedObject(self, kServicesKey);
}

@end
