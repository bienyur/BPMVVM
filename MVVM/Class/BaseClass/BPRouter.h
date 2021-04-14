//
//  BPRouter.h
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//  路由 通过反射及viewModel-controller 对照表进行相关业务操作

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BPViewModelProtocol.h"
#import "BPViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPRouter : NSObject

/// 构造方法
+ (instancetype)sharedInstance;

/// 配置路由表
@property (nonatomic, strong, readonly) NSDictionary *viewModelViewMappings;

/// 通过 view model 获取 view controller
/// @param viewModel view model
- (UIViewController *)viewControllerForViewModel:(id <BPViewModelProtocol>)viewModel;
@end

NS_ASSUME_NONNULL_END
