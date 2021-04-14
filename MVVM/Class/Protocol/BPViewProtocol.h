//
//  BPViewProtocol.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//  mvvm下，view的生命周期协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BPViewProtocol <NSObject>

- (void)bindViewModel:(id <BPViewProtocol>)viewModel;

@required

/// 配置额外数据
- (void)mvvm_initializeForView;

/// 添加视图
- (void)mvvm_createViewForView;

@end

NS_ASSUME_NONNULL_END
