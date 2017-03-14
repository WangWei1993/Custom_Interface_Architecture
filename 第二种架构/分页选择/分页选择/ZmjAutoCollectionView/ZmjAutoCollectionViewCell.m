//
//  ZmjAutoCollectionViewCell.m
//  ZmjAutoCollectionView
//
//  Created by 郑敏捷 on 16/8/31.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import "ZmjAutoCollectionViewCell.h"

@interface ZmjAutoCollectionViewCell()

@property (strong, nonatomic) UIImageView *ZmjImageView;

@end

@implementation ZmjAutoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.ZmjImageView];
        
        [self makeSubViewsConstraints];
    }
    return self;
}

- (void)makeSubViewsConstraints {
    
    [self.ZmjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self.contentView);
    }];
}

- (UIImageView *)ZmjImageView {
    if (!_ZmjImageView) {
        _ZmjImageView = [[UIImageView alloc]init];
    }
    return _ZmjImageView;
}

@end
