//
//  MyView.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "MyView.h"
#import "Masonry.h"
#import "WWChildScrollViewCell.h"
#import "WWTitleScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define TitleScrollViewH 60
#define BannerH 300

@interface MyView () <UITableViewDelegate, UITableViewDataSource, WWTitleScrollViewDelegate, WWChildScrollViewCellDelegate>

@property(nonatomic, weak) UITableView *tableView;

/** WWTitleScrollView */
@property (nonatomic, weak) WWTitleScrollView *titleScrollView;

/** WWChildScrollViewCell */
@property (nonatomic, weak) WWChildScrollViewCell *childScrollViewCell;

@end

@implementation MyView

- (instancetype)init {
    if (self = [super init]) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
        self.tableView = tableView;
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor redColor];
        
        // 注册两个cell
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [tableView registerClass:[WWChildScrollViewCell class] forCellReuseIdentifier:@"WWChildScrollViewCell"];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
        
    } else {
        return 1;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.textLabel.text = @"我是一个Banner";
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
        
    } else {
        // 分页
        WWChildScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WWChildScrollViewCell"];
        self.childScrollViewCell = cell;
        cell.titleArr = _titleArr;
        cell.ww_delegate = self;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        WWTitleScrollView *titleScrollView = [[WWTitleScrollView alloc] init];
        titleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, TitleScrollViewH);
        titleScrollView.titleArr = _titleArr;
        titleScrollView.ww_delegate = self;
        self.titleScrollView = titleScrollView;
        return titleScrollView;
    
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return BannerH;
        
    } else {
        return SCREEN_HEIGHT + BannerH - TitleScrollViewH;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section ==1) {
        return TitleScrollViewH;
        
    } else {
        return 0;
        
    }
}

#pragma mark - WWTitleScrollViewDelegate
- (void)titleScrollViewSelectedIndex:(NSInteger)index {
    [self.childScrollViewCell ww_selectedChildScrollView:index];
    
}

#pragma mark - WWChildScrollViewCellDelegate
- (void)ww_childScrollViewDidScrollView:(UIScrollView *)scrollView {
    [self.titleScrollView ww_didScrollView:scrollView];
}
- (void)ww_childScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.titleScrollView ww_didEndDecelerating:scrollView];
}

@end
