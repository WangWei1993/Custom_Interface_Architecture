//
//  WWButton.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/14.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "WWButton.h"

@implementation WWButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 设置默认\选中\高亮的字体颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // 设置默认\选中\高亮的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"blue"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"blue"] forState:UIControlStateHighlighted];
    }
    return self;
}

@end
