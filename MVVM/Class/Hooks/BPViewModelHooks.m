//
//  BPViewModelHooks.m
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPViewModelHooks.h"
#import <Aspects/Aspects.h>
#import "NSObject+MVVM.h"
#import "BPViewModelProtocol.h"

@implementation BPViewModelHooks


+ (void)load{
    [super load];
    [BPViewModelHooks sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BPViewModelHooks *instance = nil;
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
    [NSObject aspect_hookSelector:@selector(initWithServices:params:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, NSDictionary *param){
        [self _initWithInstance:aspectInfo.instance];
    } error:nil];
}

#pragma mark - Hook Methods
- (void)_initWithInstance:(NSObject <BPViewModelProtocol> *)viewModel
{
    if ([viewModel respondsToSelector:@selector(mvvm_initializeForViewModel)]) {
        [viewModel mvvm_initializeForViewModel];
    }
}

@end
