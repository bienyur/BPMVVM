//
//  BPViewModelServices.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//  mvvm模式下，整体服务的协议。统一管理跳转以及网络请求（后者未完成）

#import <Foundation/Foundation.h>
#import "BPNavigationProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BPViewModelServices <NSObject,BPNavigationProtocol>

/// Opne the url in safair
/// @param url the URL
- (void)applicationOpenURL:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END
