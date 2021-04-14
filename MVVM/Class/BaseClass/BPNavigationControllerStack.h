//
//  BPNavigationControllerStack.h
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//  navigation stack 用来处理跳转逻辑

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BPViewModelServices.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BPViewModelServices;

@interface BPNavigationControllerStack : NSObject

/// services实现
/// @param services service
- (instancetype)initWithServices:(id<BPViewModelServices>)services;
/// Pushes the navigation controller.
///
/// navigationController - the navigation controller
- (void)pushNavigationController:(UINavigationController *)navigationController;

/// Pops the top navigation controller in the stack.
///
/// Returns the popped navigation controller.
- (UINavigationController *)popNavigationController;

/// Retrieves the top navigation controller in the stack.
///
/// Returns the top navigation controller in the stack.
- (UINavigationController *)topNavigationController;

- (void )removeNavigationControllers;

@end

NS_ASSUME_NONNULL_END
