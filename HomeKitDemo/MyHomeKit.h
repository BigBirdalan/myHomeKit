//
//  MyHomeKit.h
//  HomeKitDemo
//
//  Created by 王子胜 on 16/9/25.
//  Copyright © 2016年 王子胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HomeKit/HomeKit.h>
@interface MyHomeKit : NSObject<HMHomeManagerDelegate,HMHomeDelegate>

@property (nonatomic,strong)HMHomeManager *homeManager;

- (void)initMyHomeKit;
- (void)addHome:(NSString *)homeName;
- (void)removeHome:(HMHome *)home;
@end
