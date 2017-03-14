//
//  FirstViewController.h
//  分段页面选择
//
//  Created by XLiming on 16/9/17.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@protocol firstVCChangeContentOffsetYDelegate <NSObject>

- (void)changeTableView:(UITableView *)tableView ContentOffsetY: (CGFloat)y;

@end

@interface FirstViewController : UIViewController

@property (weak, nonatomic) id<firstVCChangeContentOffsetYDelegate> delegate;

@property (strong, nonatomic, readonly) UITableView *tableView;

@end
