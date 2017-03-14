//
//  HeaderView.m
//  分页选择
//
//  Created by XLiming on 16/9/18.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

@property (strong, nonatomic) ZmjAutoCollectionView *zmjAutoCollectionView;

@property (strong, nonatomic) MenuView *menuView;

@end

@implementation HeaderView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self addSubview:self.zmjAutoCollectionView];
        [self addSubview:self.menuView];
    }
    return self;
}

//- (void)setPicArray:(NSArray *)picArray {
//
//    _picArray = picArray;
//    
//    [_zmjAutoCollectionView initWithTimer:2.0 withImagesArray:_picArray];
//}

- (ZmjAutoCollectionView *)zmjAutoCollectionView{
    if (!_zmjAutoCollectionView) {
        _zmjAutoCollectionView       = [[ZmjAutoCollectionView alloc]init];
        _zmjAutoCollectionView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth / 2);
    }
    return _zmjAutoCollectionView;
}

- (MenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MenuView alloc]init];
        _menuView.frame = CGRectMake(0, ScreenWidth / 2, ScreenWidth, 50);
    }
    return _menuView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
