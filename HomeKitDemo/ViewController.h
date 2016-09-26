//
//  ViewController.h
//  HomeKitDemo
//
//  Created by 王子胜 on 16/9/22.
//  Copyright © 2016年 王子胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHomeKit.h"
@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)MyHomeKit *homekit;
@property (nonatomic,strong)NSArray *homeArry;
@property (nonatomic,strong)HMHome *currentHome;
@property (nonatomic,strong)NSArray *roomArry;

@property (weak, nonatomic) IBOutlet UILabel *currentHomeName;
@property (weak, nonatomic) IBOutlet UICollectionView *roomCollectionView;


@end

