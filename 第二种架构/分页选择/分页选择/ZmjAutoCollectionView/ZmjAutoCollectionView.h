//
//  ZmjAutoCollectionView.h
//  ZmjAutoCollectionView
//
//  Created by 郑敏捷 on 16/8/31.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef void(^imageViewActionBlock)(NSInteger indexPath);

@interface ZmjAutoCollectionView : UIView
// 点击所在页面Block
@property (copy, nonatomic)imageViewActionBlock imageViewBlock;
// 外部接口
- (void)initWithTimer:(NSTimeInterval)playTime
      withImagesArray:(NSArray *)imageArray;
// 开启定时器
- (void)startTimer;
// 关闭定时器
- (void)stopTimer;

@end
