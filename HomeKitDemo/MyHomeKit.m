//
//  MyHomeKit.m
//  HomeKitDemo
//
//  Created by 王子胜 on 16/9/25.
//  Copyright © 2016年 王子胜. All rights reserved.
//

#import "MyHomeKit.h"

@implementation MyHomeKit
- (void)initMyHomeKit
{
    self.homeManager=[[HMHomeManager alloc]init];
    self.homeManager.delegate = self;
}
#pragma mark -
#pragma mark home的操作方法
- (void)addHome:(NSString *)homeName{
    [self.homeManager addHomeWithName:homeName completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
        
    }];
}
- (void)removeHome:(HMHome *)home{
    [self.homeManager removeHome:home completionHandler:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark -
#pragma mark HMHomeManager代理方法（4个）
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager{
    NSLog(@"已经获取到homes数据：%@",manager.homes);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getHomes" object:nil userInfo:nil];
}
- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager{
     NSLog(@"已经更新了primaryHome：%@",manager.primaryHome);
}
- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home
{    NSLog(@"已经添加了home：%@",home);
}
- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home
{
     NSLog(@"已经移除了home：%@",home);
}
//这里把这些方法放在这里  作为参考

#pragma mark -
#pragma mark home代理方法
- (void)homeDidUpdateName:(HMHome *)home
{
    NSLog(@"已经更换了home的名字");
}
- (void)home:(HMHome *)home didAddAccessory:(HMAccessory *)accessory{
    NSLog(@"已经添加了，智能设备");
}
- (void)home:(HMHome *)home didRemoveAccessory:(HMAccessory *)accessor{
    
    NSLog(@"已经移除了智能设备");
}

- (void)home:(HMHome *)home didAddUser:(HMUser *)user{
    
    NSLog(@"已经添加用户");
    
}
- (void)home:(HMHome *)home didRemoveUser:(HMUser *)user{
    NSLog(@"已经移除了用户");
    
    
}
- (void)home:(HMHome *)home didUpdateRoom:(HMRoom *)room forAccessory:(HMAccessory *)accessory{
    
    NSLog(@"一个新房间，添加了一个智能设备");
    
}
- (void)home:(HMHome *)home didAddRoom:(HMRoom *)room{
    
    NSLog(@"已经添加了房间 ");
    
    
}
- (void)home:(HMHome *)home didRemoveRoom:(HMRoom *)room{
    
    
    NSLog(@"已经移除了房间");
    
}
- (void)home:(HMHome *)home didUpdateNameForRoom:(HMRoom *)room{
    
    NSLog(@"已经为一个房间更新了名字");
}
- (void)home:(HMHome *)home didAddZone:(HMZone *)zone{
    
    NSLog(@"已经添加了一个空间");
    
}
- (void)home:(HMHome *)home didRemoveZone:(HMZone *)zone{
    
    NSLog(@"已经移除了一个空间");
}
- (void)home:(HMHome *)home didUpdateNameForZone:(HMZone *)zone{
    
    NSLog(@"已经为一个空间更改了名字");
    
    
}
- (void)home:(HMHome *)home didAddRoom:(HMRoom *)room toZone:(HMZone *)zone{
    
    NSLog(@"已经添加了一个房间到一个空间");
    
}
- (void)home:(HMHome *)home didRemoveRoom:(HMRoom *)room fromZone:(HMZone *)zone{
    
    NSLog(@"已经从一个空间移除了一个房间");
}
- (void)home:(HMHome *)home didAddServiceGroup:(HMServiceGroup *)group{
    
    NSLog(@"已经添加了一个服务组");
    
}
- (void)home:(HMHome *)home didRemoveServiceGroup:(HMServiceGroup *)group{
    
    NSLog(@"已经移除了一个服务组");
}
- (void)home:(HMHome *)home didUpdateNameForServiceGroup:(HMServiceGroup *)group{
    NSLog(@"已经为一个服务组更改了名字");
    
    
}
- (void)home:(HMHome *)home didAddService:(HMService *)service toServiceGroup:(HMServiceGroup *)group{
    
    NSLog(@"已经为一个服务组添加了一个服务");
    
    
}
- (void)home:(HMHome *)home didRemoveService:(HMService *)service fromServiceGroup:(HMServiceGroup *)group{
    
    NSLog(@"已经为一个服务组移除了一个服务");
    
}

- (void)home:(HMHome *)home didAddActionSet:(HMActionSet *)actionSet{
    
    NSLog(@"已经添加了一个动作组");
    
    
}
- (void)home:(HMHome *)home didRemoveActionSet:(HMActionSet *)actionSet{
    
    NSLog(@"已经移除了一个动作组");
    
}
- (void)home:(HMHome *)home didUpdateNameForActionSet:(HMActionSet *)actionSet{
    
    NSLog(@"已经为一个设置组添加了名字");
    
}
- (void)home:(HMHome *)home didUpdateActionsForActionSet:(HMActionSet *)actionSet{
    
    NSLog(@"已经为一个设置组更新了一个设置动作");
}
- (void)home:(HMHome *)home didAddTrigger:(HMTrigger *)trigger{
    
    
    NSLog(@"已经添加了一个触发器");
    
}
- (void)home:(HMHome *)home didRemoveTrigger:(HMTrigger *)trigger{
    
    NSLog(@"已经移除了一个触发器");
    
}

- (void)home:(HMHome *)home didUpdateNameForTrigger:(HMTrigger *)trigg{
    
    
    NSLog(@"已经移除了一个触发器");
    
}
- (void)home:(HMHome *)home didUpdateTrigger:(HMTrigger *)trigger{
    
    
    NSLog(@"已经更新了触发器");
    
    
}
- (void)home:(HMHome *)home didUnblockAccessory:(HMAccessory *)accessor{
    
    
    NSLog(@"已经接通了智能设备");
    
    
    
}
- (void)home:(HMHome *)home didEncounterError:(NSError*)error forAccessory:(HMAccessory *)accessory{
    
    NSLog(@"已经遇到错误");
    
    
    
}

@end
