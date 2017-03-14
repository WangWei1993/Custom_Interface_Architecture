//
//  TitleScrollView.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "WWTitleScrollView.h"
#import "Masonry.h"
#import "WWButton.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define WWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WWRandomColor WWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface WWTitleScrollView ()

/** 滚动选择View */
@property (nonatomic, weak) UIView *selectView;

/** 高亮选择Lable */
@property (nonatomic, weak) WWButton *selectBtn;

@end

@implementation WWTitleScrollView

- (instancetype)init {
    if (self = [super init]) {
        
        // 初始化设置
        self.backgroundColor = [UIColor grayColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;// 没有回弹效果
        // self
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    
    // 创建子控件（根据传入的标题创建控件）
    [self setupChildView];
    
    // 布局
    [self setupChildViewLayout];
    
    // 设置默认
    [self setDefault];
    
}

// 设置默认
- (void)setDefault {
    self.selectBtn.selected = YES;
    
}

// 更改选中
- (void)setSelectedBtn:(WWButton *)btn {
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    
}

// 布局
- (void)setupChildViewLayout {
    
    // 展示所有子控件（需要注意：UIScrollView中默认是有两个imageView滚动条）
    NSLog(@"---%zd----,%@",self.subviews.count ,self.subviews);
    
    // 获取第一个控件
    WWButton *beforBtn = self.subviews[0];
    
    
    // 比例
    CGFloat a = 1.0 / _titleArr.count;
    
    // 添加子控件
    for (int i = 0; i < self.subviews.count - 1; i++) {
        
        WWButton *btn = self.subviews[i];
        btn.index = i;
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            // btn触发代理事件
            if ([self.ww_delegate respondsToSelector:@selector(titleScrollViewSelectedIndex:)]) {
                [self.ww_delegate titleScrollViewSelectedIndex:btn.index];
            }
            
            // btn选择高亮
            [self setSelectedBtn:btn];
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(0);
            } else {
                make.left.mas_equalTo(beforBtn.mas_right);
            }
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(self).multipliedBy(a);
            make.height.mas_equalTo(self);
        }];
        beforBtn = btn;
        
        // 获取第一个控件
        if (i == 0) {
            self.selectBtn = btn;
        }
    }
    
    // 滚动高亮View
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(self).multipliedBy(a);
    }];
}

// 创建子控件
- (void)setupChildView {
    
    // 1. 添加子控件
    for (int i = 0; i <_titleArr.count ;i++) {
        WWButton *btn = [[WWButton alloc] init];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
    // 2. 高亮滚动View
    UIView *selectView = [[UIView alloc] init];
    self.selectView = selectView;
    [self addSubview:selectView];
}

#pragma mark - 对外方法
/** didScrollView */
- (void)ww_didScrollView:(UIScrollView *)scrollView {
    
    //WWButton *btn = (WWButton *)[self viewWithTag:tag];
    
}

/** didEndDecelerating */
- (void)ww_didEndDecelerating:(UIScrollView *)scrollView {

    NSInteger tag = scrollView.contentOffset.x / self.frame.size.width;
    
    for (WWButton *btn in self.subviews) {
        
        if ([btn isKindOfClass:[WWButton class]] && btn.index == tag) {
            [self setSelectedBtn:btn];
            
        }
    }
}


@end
