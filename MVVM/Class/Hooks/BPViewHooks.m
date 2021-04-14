//
//  BPViewHooks.m
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPViewHooks.h"
#import <Aspects/Aspects.h>
#import "BPViewProtocol.h"

@implementation BPViewHooks

+ (void)load{
    [super load];
    [BPViewHooks sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BPViewHooks *instance = nil;
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
    
    /// 方法拦截
    
    // 代码方式唤起view
    [UIView aspect_hookSelector:@selector(initWithFrame:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, CGRect frame){
        
        [self _init:aspectInfo.instance withFrame:frame];
    }  error:nil];
    
    // xib方式唤起view
    [UIView aspect_hookSelector:@selector(initWithCoder:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, NSCoder *aDecoder){
        
        // 在此时 IBOut 中 view 都为空， 需要Hook awakeFromNib 方法
        [self _init:aspectInfo.instance withCoder:aDecoder];
    } error:nil];
    
    // xib方式唤起view
    [UIView aspect_hookSelector:@selector(awakeFromNib) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        
        // 这时候可以初始化视图
        [self _awakFromNib:aspectInfo.instance];
    } error:nil];
}

#pragma mark - Hook Methods
- (void)_init:(UIView <BPViewProtocol>*)view withFrame:(CGRect)frame
{
    if (![view conformsToProtocol:@protocol(BPViewProtocol)]) {
        return;
    }
    
    if ([view respondsToSelector:@selector(mvvm_initializeForView)]) {
        [view mvvm_initializeForView];
    }
    
    if ([view respondsToSelector:@selector(mvvm_createViewForView)]) {
        [view mvvm_createViewForView];
    }
}

- (void)_init:(UIView <BPViewProtocol>*)view withCoder:(NSCoder *)aDecoder
{
    if (![view conformsToProtocol:@protocol(BPViewProtocol)]) {
        return;
    }
    
    if ([view respondsToSelector:@selector(mvvm_initializeForView)]) {
        [view mvvm_initializeForView];
    }
}

- (void)_awakFromNib:(UIView <BPViewProtocol>*)view
{
    if (![view conformsToProtocol:@protocol(BPViewProtocol)]) {
        return;
    }
    if ([view respondsToSelector:@selector(mvvm_createViewForView)]) {
        [view mvvm_createViewForView];
    }
}


@end
