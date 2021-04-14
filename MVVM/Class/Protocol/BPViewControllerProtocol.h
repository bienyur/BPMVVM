//
//  BPViewControllerProtocol.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//  mvvm模式下，ViewController的生命周期协议

#import <Foundation/Foundation.h>
#import "BPViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BPViewControllerProtocol <NSObject>

/// 初始化UI界面
- (void)mvvm_initSubViews;

/// 配置默认参数
- (void)mvvm_setupDefault;

/// 配置导航栏
- (void)mvvm_setupNavigationItems;

/// 绑定数据
- (void)mvvm_bindViewModelForController;

@end

NS_ASSUME_NONNULL_END
