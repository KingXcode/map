//
//  HTRightMenuViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/8.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

/*
 
 MAMapTypeStandard = 0,  ///< 普通地图
 MAMapTypeSatellite,     ///< 卫星地图
 MAMapTypeStandardNight, ///< 夜间视图
 MAMapTypeNavi,          ///< 导航视图
 MAMapTypeBus            ///< 公交视图
 
 */

#import "HTRightMenuViewController.h"
#import "HTColor.h"
#import <Masonry.h>
#import "HTMapSelectTypeCell.h"
#import "HTMapManager.h"
#import <RESideMenu.h>


@interface HTRightMenuModel:NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * detailTitle;
@property (nonatomic,assign) BOOL isOpen;
@end

@implementation HTRightMenuModel
-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isOpen] forKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",self.title]];
}
@end

@interface HTRightMenuViewController ()<UITableViewDelegate,UITableViewDataSource,HTMapSelectTypeCellDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,copy) NSArray * titleArrays;

@property (nonatomic,copy) NSArray * actionArray;

@end

@implementation HTRightMenuViewController

-(NSArray *)titleArrays
{
    if (_titleArrays == nil) {
        _titleArrays = @[@"主题",@"事件",@"其它"];
    }
    return _titleArrays;
}

-(NSArray *)actionArray
{
    if (_actionArray == nil) {
        HTRightMenuModel *model_0 = [[HTRightMenuModel alloc]init];
        model_0.title = @"屏幕常亮";
        model_0.detailTitle = nil;
        NSNumber *num0 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",model_0.title]];
        model_0.isOpen = num0.boolValue;
        
        HTRightMenuModel *model_1 = [[HTRightMenuModel alloc]init];
        model_1.title = @"旋转手势";
        model_1.detailTitle = @"图区双指旋转触发";
        NSNumber *num1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",model_1.title]];
        model_1.isOpen = num1.boolValue;
        
        HTRightMenuModel *model_2 = [[HTRightMenuModel alloc]init];
        model_2.title = @"切换视角";
        model_2.detailTitle = @"图区双指垂直上下滑动切换";
        NSNumber *num2 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",model_2.title]];
        model_2.isOpen = num2.boolValue;
        
        HTRightMenuModel *model_3 = [[HTRightMenuModel alloc]init];
        model_3.title = @"地图上显示常用地址";
        model_3.detailTitle = nil;
        NSNumber *num3 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",model_3.title]];
        model_3.isOpen = num3.boolValue;
        
        HTRightMenuModel *model_4 = [[HTRightMenuModel alloc]init];
        model_4.title = @"显示推荐的常用地址";
        model_4.detailTitle = nil;
        NSNumber *num4 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"HTRightMenuModel_%@",model_4.title]];
        model_4.isOpen = num4.boolValue;
        
        _actionArray = @[model_0,model_1,model_2,model_3,model_4];
    }
    return _actionArray;
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

#pragma -mark- cell delegate
-(void)didselectType:(NSInteger)type
{
    [HTMapManager sharedManager].mapView.mapType = type;
    [self.sideMenuViewController hideMenuViewController];
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
    
    if (indexPath.section == 0)
    {
        HTMapSelectTypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:@"HTMapSelectTypeCell"];
        if (typeCell == nil) {
            typeCell = [[HTMapSelectTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HTMapSelectTypeCell"];
        }
        typeCell.delegate = self;
        return typeCell;
    }
    
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
        return 88;
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
