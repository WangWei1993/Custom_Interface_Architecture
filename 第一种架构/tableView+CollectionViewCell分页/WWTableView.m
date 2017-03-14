//
//  WWTableView.m
//  tableView+CollectionViewCell分页
//
//  Created by 王伟 on 2017/3/14.
//  Copyright © 2017年 王伟. All rights reserved.
//

#import "WWTableView.h"
#import "Masonry.h"

@interface WWTableView () <UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation WWTableView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        
        // 注册cell
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell1"];
        
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%@组----%zd",_desC, indexPath.row];
    return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
    
}

- (void)setDesC:(NSString *)desC {
    _desC = desC;
    [self.tableView reloadData];
}

@end
