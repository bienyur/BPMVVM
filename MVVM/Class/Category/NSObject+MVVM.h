//
//  NSObject+MVVM.h
//  MVVM_Example
//
//  Created by 404 on 2020/11/18.
//  Copyright © 2020 xuhongji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPViewModelServices.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MVVM)

/// 去表征化参数
@property (nonatomic, strong, readonly) NSDictionary *params;

/// 为 viewModel 提供的services
@property (nonatomic, readonly, strong) id<BPViewModelServices> services;

/// viewModel 构造方法
/// @param services 服务
/// @param params 扩展参数
- (instancetype)initWithServices:(id<BPViewModelServices>)services params:(NSDictionary * _Nullable)params;

@end

NS_ASSUME_NONNULL_END
