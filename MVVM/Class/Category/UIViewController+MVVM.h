//
//  UIViewController+MVVM.h
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//  ViewController的类别，为其提供ViewModel绑定操作

#import <UIKit/UIKit.h>
#import "BPViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MVVM)

@property(nonatomic, strong, readonly) id<BPViewModelProtocol> viewModel;

/// 构造方法
/// @param viewModel viewModel
- (instancetype)initWithViewModel:(id<BPViewModelProtocol>)viewModel;

@end

NS_ASSUME_NONNULL_END
