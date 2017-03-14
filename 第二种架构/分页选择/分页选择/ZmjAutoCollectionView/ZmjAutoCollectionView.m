//
//  ZmjAutoCollectionView.m
//  ZmjAutoCollectionView
//
//  Created by 郑敏捷 on 16/8/31.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import "ZmjAutoCollectionView.h"
#import "ZmjAutoCollectionViewCell.h"

//#import "UIImageView+WebCache.h"

@interface ZmjAutoCollectionView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

// 表格
@property (strong, nonatomic) UICollectionView           *collectionView;
// 布局
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
// 页面控制器
@property (strong, nonatomic) UIPageControl              *pageControl;
// 占位图数组
@property (strong, nonatomic) NSArray                    *imageArray;
// 传入的图片数组
@property (strong, nonatomic) NSMutableArray             *imagesArray;
// 定时器
@property (strong, nonatomic) NSTimer                    *timer;
// 定时器时间
@property (assign, nonatomic) NSTimeInterval              delayTime;
// 记录当前所在页数
@property (assign, nonatomic) NSInteger                   currentPage;
// cell总数
@property (assign, nonatomic) NSInteger                   totalCount;

@end

@implementation ZmjAutoCollectionView

- (instancetype)init {
    if (self = [super init]) {
        
        [self addSubview:self.collectionView];
        
        // 滚动视图无图片时，加载本地的一张占位图
        _imageArray = @[@"zwt"];
        _totalCount = _imageArray.count;
        
        [self imagesArray];
    }
    return self;
}

- (void)initWithTimer:(NSTimeInterval)playTime
      withImagesArray:(NSArray *)imageArray {
    
    _delayTime = playTime; // 定时器时间
    
    [_imagesArray removeAllObjects];
    
    [_imagesArray addObjectsFromArray:imageArray]; // 图片数组
    
    if (_pageControl) [_pageControl removeFromSuperview];  // 将已有的_pageControl移除
    
    _currentPage = 0;  // 默认页数置为0
    
    if (_imagesArray.count > 1) {
        
        _totalCount = _imagesArray.count * 100; // 给cell总数
        
        [self startTimer]; // 开启定时器
        
        [self addSubview:self.pageControl];  // 加载_pageControl
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];  // 默认显示第一页
    }
    
    _pageControl.currentPage = 0;  // 默认第一个点
    
    [_collectionView reloadData];  // 刷新滚动视图
}

// 设置单元格的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _totalCount;
}

// 设置段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    ZmjAutoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"string" forIndexPath:indexPath];
    
    if (_imagesArray.count == 0) {
        
        cell.ZmjImageView.image = [UIImage imageNamed:_imageArray[indexPath.row % _imageArray.count]];
        
    }else {
        
//        [cell.ZmjImageView sd_setImageWithURL:_imagesArray[indexPath.row % _imagesArray.count][@"NewImage"] placeholderImage:[UIImage imageNamed:@"zwt"]];
        cell.ZmjImageView.image = [UIImage imageNamed:_imagesArray[indexPath.row % _imagesArray.count]];
    }

    return cell;
}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 单元格默认大小：50*50
    // 第一个参数：设置单元格的宽
    // 第二个参数：设置单元格的高
    return CGSizeMake(ScreenWidth, ScreenWidth / 2);
}

// cell与cell之间的间隔，边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 上左下右
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 设置垂直最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置水平最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

// 设置标题头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // 第一个参数：只有当水平滑动时有效
    // 第二个参数：只有当垂直滑动时有效
    return CGSizeMake(0, 0);
}

// 单元格的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 点击事件Block传递
    if (_imagesArray.count > 0) {
        
        if (self.imageViewBlock) {
            
            self.imageViewBlock(indexPath.row % _imagesArray.count);
        }
    }
}

- (void)startTimer {
    
    if (!_timer) {
        
        _timer = [NSTimer timerWithTimeInterval:_delayTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

-(void)nextPage {
    
    _currentPage ++;
    
    if (_currentPage >= _totalCount){
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_totalCount / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
        _currentPage = _totalCount / 2;
        
    }else {
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 关闭定时器
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 开启定时器
    if (_imagesArray.count > 1) {
        
        [self startTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取当前所在页数
    NSInteger page           = scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    // 获取当前对应的 _pageControl.currentPage
    _pageControl.currentPage = page % _imagesArray.count;
    // 获取当前所在_currentPage进行赋值
    _currentPage             = page;
}

- (void)stopTimer {
    // 将定时器移除
    if (_timer) {
        
        [_timer invalidate];
        _timer= nil;
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionViewLayout                          = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 2) collectionViewLayout:_collectionViewLayout];
        _collectionViewLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces                        = NO;
        _collectionView.pagingEnabled                  = YES;
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.scrollsToTop = NO;
        // 注册cell
        [_collectionView registerClass:[ZmjAutoCollectionViewCell class] forCellWithReuseIdentifier:@"string"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl                               = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
        _pageControl.numberOfPages                 = _imagesArray.count;
        _pageControl.currentPage                   = 0;
        _pageControl.userInteractionEnabled        = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor        = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc]init];
    }
    return _imagesArray;
}

- (void)dealloc {
    
    [self stopTimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
