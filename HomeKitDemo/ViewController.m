//
//  ViewController.m
//  HomeKitDemo
//
//  Created by 王子胜 on 16/9/22.
//  Copyright © 2016年 王子胜. All rights reserved.
//

#import "ViewController.h"
#import "RoomColViewCell.h"
#import "currentRoomVC.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    self.homekit = [[MyHomeKit alloc]init];
    [self.homekit initMyHomeKit];
    self.homeArry = [[NSArray alloc]init];
    self.roomArry = [[NSArray alloc]init];
    self.roomCollectionView.delegate =self;
    self.roomCollectionView.dataSource =self;
     //注册  已经获取到全部home信息的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHomesNotify) name:@"getHomes" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -
#pragma mark UIcollection代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.roomArry.count+1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    RoomColViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row<self.roomArry.count) {
        HMRoom *room =self.roomArry[indexPath.row];
        NSString *name = room.name;
        cell.nameLab.text =name;
    }else{
        cell.nameLab.text =@"+";
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<self.roomArry.count) {
//     跳转到对应的房间
        HMRoom *room =self.roomArry[indexPath.row];
        NSLog(@",里是%@",room.name);
        currentRoomVC *curVC = [[currentRoomVC alloc]init];
        curVC.currentRoom = room;
        [self.navigationController pushViewController:curVC animated:YES];
    }else{
       __weak typeof (self) weakSelf = self;
        UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"请输入新room的名字" message:@"请确保这个名字的唯一性" preferredStyle:1];
        [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"请输入room的名字";
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            NSString *newName =inputNameAlter.textFields.firstObject.text;
        NSLog(@"添加了房间%@",newName);
        [self.currentHome addRoomWithName:newName completionHandler:^(HMRoom * _Nullable room, NSError * _Nullable error) {
            if (!error) {
               [weakSelf updateCurrentHomeRooms:weakSelf.currentHome];
            }
            }];
        }];
        [inputNameAlter addAction:action1];
        [inputNameAlter addAction:action2];
        [self presentViewController:inputNameAlter animated:YES completion:^{}];
    }
}
#pragma mark -
#pragma mark 通知回调方法
- (void)getHomesNotify{
    self.currentHome = self.homekit.homeManager.primaryHome;
    [self updateCurrentHome];
    [self updateCurrentHomeRooms:self.currentHome];
}
- (void)updateCurrentHome{
    self.currentHomeName.text =[NSString stringWithFormat:@"当前的home为：%@",self.currentHome.name];
}
- (void)updateCurrentHomeRooms:(HMHome *)home{
    NSLog(@"开始更新rooms数据");
    if (home.rooms.count) {
       self.roomArry = home.rooms;
       for (int a=0; a<self.roomArry.count; a++) {
           HMRoom *room = self.roomArry[a];
           NSLog(@"======%@",room.name);
       }
    }else{
        self.roomArry = home.rooms;
    }
    [self.roomCollectionView reloadData];
}
#pragma mark -
#pragma mark 按钮点击事件
- (IBAction)myHomesBtnClick:(id)sender {
    if (self.homekit.homeManager.homes.count) {
        self.homeArry =self.homekit.homeManager.homes;
//        展示得到的home
        UIAlertController *homeList = [UIAlertController alertControllerWithTitle:@"" message:@"我的所有home" preferredStyle:0];
        for (int a=0; a<self.homeArry.count; a++) {
            HMHome *home = self.homeArry[a];
            NSString *name = home.name;
            if (home.primary==YES) {
                name = [NSString stringWithFormat:@"%@ primary",home.name];
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:name style:0 handler:^(UIAlertAction * _Nonnull action) {
                self.currentHome = home;
                [self updateCurrentHome];
                [self updateCurrentHomeRooms:home];
            }];
            [homeList addAction:action];
        }
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
         }];
        [homeList addAction:action1];
        [self presentViewController:homeList animated:YES completion:^{}];
    }
}
- (IBAction)addHomeBtnClick:(id)sender {

   UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"请输入新home的名字" message:@"请确保这个名字的唯一性" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入新家的名字";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSString *newName =inputNameAlter.textFields.firstObject.text;
        [self.homekit addHome:newName];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}
- (IBAction)removeHomeBtnCclik:(id)sender {
    [self.homekit removeHome:self.currentHome];
    [self getHomesNotify];
}

@end
