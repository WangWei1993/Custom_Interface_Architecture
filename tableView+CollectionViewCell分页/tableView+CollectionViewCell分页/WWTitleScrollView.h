//
//  TitleScrollView.h
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/13.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WWTitleScrollViewDelegate <NSObject>

@optional
/** 选中第几个按钮 */
- (void)titleScrollViewSelectedIndex:(NSInteger)index;

@end

@interface WWTitleScrollView : UIScrollView

/** 数据源 */
@property (nonatomic, strong) NSArray *titleArr;

/** delegate */
@property (nonatomic, weak) id<WWTitleScrollViewDelegate> ww_delegate;

/** didScrollView */
- (void)ww_didScrollView:(UIScrollView *)scrollView;

/** didEndDecelerating */
- (void)ww_didEndDecelerating:(UIScrollView *)scrollView;

@end
