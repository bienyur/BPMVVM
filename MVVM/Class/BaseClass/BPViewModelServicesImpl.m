//
//  BPViewModelServicesImpl.m
//  BasicProject
//
//  Created by 404 on 2020/10/22.
//  Copyright © 2020 404. All rights reserved.
//

#import "BPViewModelServicesImpl.h"

@implementation BPViewModelServicesImpl

#pragma mark - 写一下方法实现，防止崩溃

- (void)pushViewModel:(id<BPViewModelProtocol>)viewModel animated:(BOOL)animated{
    
}

- (void)popViewModelAnimated:(BOOL)animated{}

- (void)popToRootViewModelAnimated:(BOOL)animated{}

- (void)presentViewModel:(id<BPViewModelProtocol>)viewModel animated:(BOOL)animated completion:(VoidBlock)completion{}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion{}

- (void)applicationOpenURL:(NSURL*)url{}
@end
