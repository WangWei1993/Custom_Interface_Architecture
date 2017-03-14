//
//  MenuView.m
//  分页选择
//
//  Created by XLiming on 16/9/18.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()

@property (strong, nonatomic) UIView *lineView;

@end

@implementation MenuView

- (instancetype)init {
    
    self= [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray {

    _titleArray = titleArray;
    
    [self initView];
}

- (void)initView {
    
    for (int count = 0; count < _titleArray.count; count ++) {
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((ScreenWidth / _titleArray.count) *count, 0, ScreenWidth / _titleArray.count, 50);
        button.tag = count + 1;
        [button setTitle:_titleArray[count] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [button setTintColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (count == 0) {
            
            button.selected = YES;
        }
    }
    
    [self addSubview:self.lineView];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, 48, ScreenWidth / 3, 2);
        _lineView.backgroundColor = [UIColor orangeColor];
    }
    return _lineView;
}

- (void)btnAction:(UIButton *)sender {
    
    [sender setSelected:YES];
    NSArray *subArray = self.subviews;
    for (UIButton *subbutton  in subArray) {
        if ([subbutton isKindOfClass:[UIButton class]]) {
            if (subbutton != sender) {
                [subbutton setSelected:NO];
            }
        }
    }
    
    if (self.vcBtnBlock) {
        self.vcBtnBlock(sender.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
