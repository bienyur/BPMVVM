//
//  BPNavigationProtocol.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//  mvvm模式下，为其提供的跳转协议

#import <Foundation/Foundation.h>
#import "BPViewModelProtocol.h"
#import "BPConstant.h"

@protocol BPNavigationProtocol <NSObject>

/// Push the corresponding view controller
/// @param viewModel view model
/// @param animated animation or not
- (void)pushViewModel:(id<BPViewModelProtocol>)viewModel animated:(BOOL)animated;

/// Pops the top view controller in the stack.
/// @param animated use animation or not
- (void)popViewModelAnimated:(BOOL)animated;

/// Pops until there's only a single view controller left on the stack.
/// @param animated animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;

/// Present the corresponding view controller.
/// @param viewModel the view model
/// @param animated user animation or not
/// @param completion the completion handler
- (void)presentViewModel:(id<BPViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

/// Dismiss the presented view controller.
/// @param animated use animation or not
/// @param completion the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;



@end

