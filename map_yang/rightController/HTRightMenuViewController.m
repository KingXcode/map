//
//  HTRightMenuViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTRightMenuViewController.h"
#import "HTColor.h"
#import <Masonry.h>

@interface HTRightMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,copy) NSArray * titleArrays;
@end

@implementation HTRightMenuViewController

-(NSArray *)titleArrays
{
    if (_titleArrays == nil) {
        _titleArrays = @[@"主题",@"事件",@"其它"];
    }
    return _titleArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [HTColor ht_whiteColor];
    [self creatUI];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.backgroundColor = [HTColor ht_whiteColor];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view).mas_offset(self.view.safeAreaInsets.top+[[UIApplication sharedApplication] statusBarFrame].size.height);
            make.right.equalTo(self.view).mas_offset(self.view.safeAreaInsets.right);
            make.bottom.equalTo(self.view).mas_offset(self.view.safeAreaInsets.bottom);
        } else {
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
        make.width.mas_equalTo(self.view.frame.size.width*0.57);
    }];
}

#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArrays.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"cell";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 150;
    }
    else if (indexPath.section == 1)
    {
        return 150;
    }
    else
    {
        return 44;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[HTColor textColor_333333] forState:UIControlStateNormal];
    [button setBackgroundColor:[HTColor ht_emptyColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitle:self.titleArrays[section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    return button;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
