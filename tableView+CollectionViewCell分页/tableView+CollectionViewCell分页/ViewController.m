//
//  ViewController.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 获取网络数据
    [self getData:^(NSArray *titleArr) {
        
        // 创建和布局子控件
        MyView *myView = [[MyView alloc] init];
        [self.view addSubview:myView];
        [myView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self.view);
        }];
        
        myView.titleArr = titleArr;
    }];
}

- (void)getData:(void(^)(NSArray *titleArr))block {
  
    //NSArray *arr = @[@"第1个",@"第2个",@"第3个",@"第4个",@"第5个"];
    NSArray *arr = @[@"第1个",@"第2个",@"第3个",@"第4个"];
    block(arr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
