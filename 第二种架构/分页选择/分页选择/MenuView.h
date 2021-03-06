//
//  MenuView.h
//  分页选择
//
//  Created by XLiming on 16/9/18.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef void(^vcBtnActionBlock)(NSInteger tag);

@interface MenuView : UIView

@property (copy, nonatomic) vcBtnActionBlock vcBtnBlock;

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic, readonly) UIView *lineView;

@end
