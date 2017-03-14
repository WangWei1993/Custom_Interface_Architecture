//
//  HeaderView.h
//  分页选择
//
//  Created by XLiming on 16/9/18.
//  Copyright © 2016年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZmjAutoCollectionView.h"
#import "MenuView.h"

@interface HeaderView : UIView

//@property (strong, nonatomic) NSArray *picArray;

@property (strong, nonatomic, readonly) ZmjAutoCollectionView *zmjAutoCollectionView;

@property (strong, nonatomic, readonly) MenuView *menuView;

@end
