//
//  HTPOIAroundSearchController.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/12/4.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIAroundSearchController.h"
#import "HTPoiCell.h"

@interface HTPOIAroundSearchController ()<AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString * type;
@property (nonatomic,strong) AMapSearchAPI * searchApi;
@property (nonatomic, strong) NSMutableArray<AMapPOI *> *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,weak)   UITableView * tableView;

@end

@implementation HTPOIAroundSearchController

-(instancetype)initWithType:(NSString *)type poi:(AMapPOI *)poi;
{
    self = [super init];
    if (self) {
        _type = type;
        _poi = poi;
        _dataArray = [NSMutableArray array];
        _page = 1;
        _searchApi = [[AMapSearchAPI alloc]init];
        _searchApi.delegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [HTColor ht_whiteColor];
    
    if (_poi == nil) {
        [HTProgressHUD showMessage:@"错误!" forView:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    self.navigationItem.prompt = [NSString stringWithFormat:@"%@",_poi.name];
    self.title = [NSString stringWithFormat:@"附近的建筑"];
   
    [self creatUI];
    [HTProgressHUD LoadingShowMessage:self.poi.name andDetailMessage:@"正在搜索中..." forView:self.view clickedCancel:nil];
    [self requestData];
    
}

-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.backgroundColor = [HTColor ht_whiteColor];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IphoneWidth, 0.1)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IphoneWidth, 0.1)];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
}


-(void)refresh
{
    self.page = 1;
    [self.dataArray removeAllObjects];
    [self requestData];
}

-(void)loadMore
{
    self.page ++;
    [self requestData];
}

-(void)requestData
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:self.poi.location.latitude longitude:self.poi.location.longitude];
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.requireSubPOIs      = YES;
    request.keywords            = _type;
    request.page                = self.page;
    [self.searchApi AMapPOIAroundSearch:request];
}


#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTPoiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HTPoiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row>=self.dataArray.count) {
        cell.textLabel.text = @"";
        return cell;
    }
    AMapPOI *poi = self.dataArray[indexPath.row];
    [cell configModel:poi andIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI *poi = self.dataArray[indexPath.row];
    NSString *name = poi.name;
    NSString *type = [NSString stringWithFormat:@"类型:   %@",[poi.type stringByReplacingOccurrencesOfString:@";" withString:@"\n类型:   "]];
    NSString *tel = [NSString stringWithFormat:@"电话号码:   %@",[poi.tel stringByReplacingOccurrencesOfString:@";" withString:@"\n电话号码:   "]];
    NSString *dist = [NSString stringWithFormat:@"距离查询位置:   %zd米",poi.distance];
    
    CGFloat nameHeight = [name ht_heightOfFont:[UIFont systemFontOfSize:15] limitWidth:(IphoneWidth-30)];
    CGFloat typeHeight = [type ht_heightOfFont:[UIFont systemFontOfSize:15] limitWidth:(IphoneWidth-30)];
    CGFloat telHeight  = [tel  ht_heightOfFont:[UIFont systemFontOfSize:15] limitWidth:(IphoneWidth-30)];
    CGFloat distHeight = [dist ht_heightOfFont:[UIFont systemFontOfSize:15] limitWidth:(IphoneWidth-30)];

    return 10+5+5+5+10+nameHeight+typeHeight+telHeight+distHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma -mark- AMapSearchAPI delegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    self.page--;
    [HTProgressHUD HiddenForView:self.view];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    [HTProgressHUD HiddenForView:self.view];
    [self.dataArray addObjectsFromArray:response.pois];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
