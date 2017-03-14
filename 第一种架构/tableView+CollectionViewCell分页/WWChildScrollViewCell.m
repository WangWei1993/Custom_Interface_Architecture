//
//  ScrollViewCell.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "WWChildScrollViewCell.h"
#import "Masonry.h"
#import "WWTableView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define WWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WWRandomColor WWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



@interface WWChildScrollViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView  */
@property(nonatomic, weak) UICollectionView *collectionView;

/*  流水布局属性 */
@property(nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation WWChildScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加子控件
        self.collectionView.backgroundColor = [UIColor blueColor];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        
        // 监听横竖屏
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification  object:nil];
        
    }
    return self;
}

- (void)orientChange:(NSNotification *)notification {
    
    [_collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        // 在cell中添加UICollectView
        // 
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionViewFlowLayout = collectionViewFlowLayout;
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:collectionViewFlowLayout];
        
        collectionView.scrollsToTop = YES;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.backgroundColor = [UIColor redColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
        
        // 注册cell
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self addSubview:collectionView];
    }
    return _collectionView;
}

#pragma mark - 对外方法
/** 标题点击的index */
- (void)ww_selectedChildScrollView:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - UICollectionViewDataSource 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = WWRandomColor;
    
    WWTableView *tableV = [[WWTableView alloc] initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:tableV];
    tableV.desC = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout 瀑布流布局方法
// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 上左下右
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
    
}

// 设置垂直最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

// 设置水平最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
    
}

// cell与cell之间的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsZero;
}

// 设置标题头的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
    
}

// 实时监听collectionView的contentOffset.x的变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSLog(@"scrollView.x = %f",scrollView.contentOffset.x);
    if ([self.ww_delegate respondsToSelector:@selector(ww_childScrollViewDidScrollView:)]) {
        [self.ww_delegate ww_childScrollViewDidScrollView:scrollView];
    }
    
}

// 监听减速停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if ([self.ww_delegate respondsToSelector:@selector(ww_childScrollViewDidEndDecelerating:)]) {
        [self.ww_delegate ww_childScrollViewDidEndDecelerating:scrollView];
    }
    
}

/** 监听停止拖动的时候
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}
 */

@end
