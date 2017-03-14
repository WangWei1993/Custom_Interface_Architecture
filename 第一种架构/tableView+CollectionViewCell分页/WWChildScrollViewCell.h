//
//  ScrollViewCell.h
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WWChildScrollViewCellDelegate <NSObject>

@optional
/** 实时移动View */
- (void)ww_childScrollViewDidScrollView:(UIScrollView *)scrollView;

/** 移动结束 */
- (void)ww_childScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface WWChildScrollViewCell : UITableViewCell

/** 数据源 */
@property (nonatomic, strong) NSArray *titleArr;

/** 标题点击的index */
- (void)ww_selectedChildScrollView:(NSInteger)index;

/** delegate */
@property (nonatomic, weak) id<WWChildScrollViewCellDelegate> ww_delegate;

@end
