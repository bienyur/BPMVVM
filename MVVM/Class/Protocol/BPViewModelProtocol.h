//
//  BPViewModelProtocol.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//  mvvm下，ViewModel的生命周期协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BPViewModelProtocol <NSObject>

/// 配置额外数据
- (void)mvvm_initializeForViewModel;

@end

NS_ASSUME_NONNULL_END
