//
//  RootViewController.m
//  分页选择
//
//  Created by XLiming on 16/9/18.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import "RootViewController.h"
#import "Masonry.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "HeaderView.h"

#import "UIView+WKFFrame.h"

@interface RootViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, firstVCChangeContentOffsetYDelegate, secondVCChangeContentOffsetYDelegate, thirdVCChangeContentOffsetYDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;

@property (strong, nonatomic) NSArray *vcArray;

@property (strong, nonatomic) NSArray *picArray;

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) HeaderView *headerView;

@property (strong, nonatomic) FirstViewController   *firstVC;

@property (strong, nonatomic) SecondViewController  *secondVC;

@property (strong, nonatomic) ThirdViewController   *thirdVC;

@property (assign, nonatomic) CGFloat scrollViewY;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
    
    [self initData];
}

- (void)initView {
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.headerView];
}

- (void)initData {

    _vcArray = @[[self firstVC], [self secondVC], [self thirdVC]];
    _titleArray = @[@"第一个",@"第二个",@"第三个"];
    
    _headerView.menuView.titleArray = _titleArray;
    
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _picArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
        
        [_headerView.zmjAutoCollectionView initWithTimer:2.0 withImagesArray:_picArray];
    });
    
    __weak typeof(self) weakSelf = self;
    _headerView.zmjAutoCollectionView.imageViewBlock = ^(NSInteger indexPath) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf doSomethings:indexPath];
    };
    
    _headerView.menuView.vcBtnBlock = ^(NSInteger tag) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf changeVC:tag];
    };
}

// 设置单元格的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _vcArray.count;
}

// 设置段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"string" forIndexPath:indexPath];
    
    UIViewController *vc = self.vcArray[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

// 设置单元格大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 单元格默认大小：50*50
    // 第一个参数：设置单元格的宽
    // 第二个参数：设置单元格的高
    return CGSizeMake(ScreenWidth, ScreenHeight - 64);
}

// cell与cell之间的间隔，边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //上左下右
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([_collectionView isEqual:scrollView]) {
        
        CGFloat x = scrollView.contentOffset.x / _vcArray.count;
        _headerView.menuView.lineView.x = x;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([_collectionView isEqual:scrollView]) {
        
        NSInteger tag = scrollView.contentOffset.x / ScreenWidth;
        
        UIButton *button  = (UIButton *)[_headerView.menuView viewWithTag:tag + 1];
        [button setSelected:YES];
        NSArray *subArray = _headerView.menuView.subviews;
        for (UIButton *subbutton  in subArray) {
            if ([subbutton isKindOfClass:[UIButton class]]) {
                if (subbutton != button) {
                    [subbutton setSelected:NO];
                }
            }
        }
        
        if (_scrollViewY >= 49.5) {
            
            _scrollViewY = - 50;
        }
    }
}

- (void)doSomethings:(NSInteger)indexPath {
    
    NSLog(@"点击当前页面为：%ld",indexPath);
}

- (void)changeVC:(NSInteger)tag {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:tag - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)changeTableView:(UITableView *)tableView ContentOffsetY: (CGFloat)y {
    
    CGFloat everyChange = y - _scrollViewY;
    
    _scrollViewY = y;
    
    if (_scrollViewY >= - 49.5) {
        
        _headerView.y = - (ScreenWidth / 2 - 64);
        
    }else if (_scrollViewY <= - (ScreenWidth / 2 + 50)){//固定在下面
        
        _headerView.y = 64;
        
    } else {//随着移动
        
        _headerView.y -= everyChange;
    }
    

    CGFloat tableViewOffset = y;
    NSLog(@"%f",y);
    if(y >  - 50) {
        
        tableViewOffset = - 49.5;
    }
    
    if ([tableView isEqual:_firstVC.tableView]) {
        
        _secondVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
        _thirdVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
        
    }else if ([tableView isEqual:_secondVC.tableView]) {
        
        _firstVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
        _thirdVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
        
    }else if ([tableView isEqual:_thirdVC.tableView]) {
        
        _firstVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
        _secondVC.tableView.contentOffset = CGPointMake(0, tableViewOffset);
    }
}

- (HeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HeaderView alloc]init];
        _headerView.frame = CGRectMake(0, 64, ScreenWidth, ScreenWidth / 2 + 50);
    }
    return _headerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionViewLayout                          = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
        _collectionView                                = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) collectionViewLayout:_collectionViewLayout];
        _collectionViewLayout.scrollDirection          = UICollectionViewScrollDirectionHorizontal;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces                        = NO;
        _collectionView.pagingEnabled                  = YES;
        _collectionView.dataSource                     = self;
        _collectionView.delegate                       = self;
        _collectionView.scrollsToTop = NO;
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"string"];
    }
    return _collectionView;
}

- (FirstViewController *)firstVC {
    if (!_firstVC) {
        _firstVC = [[FirstViewController alloc]init];
        _firstVC.delegate = self;
    }
    return _firstVC;
}

- (SecondViewController *)secondVC {
    if (!_secondVC) {
        _secondVC = [[SecondViewController alloc]init];
        _secondVC.delegate = self;
    }
    return _secondVC;
}

- (ThirdViewController *)thirdVC {
    if (!_thirdVC) {
        _thirdVC = [[ThirdViewController alloc]init];
        _thirdVC.delegate = self;
    }
    return _thirdVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
