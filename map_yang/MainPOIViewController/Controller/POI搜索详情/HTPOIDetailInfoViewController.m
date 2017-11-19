//
//  HTPOIDetailInfoViewController.m
//  map_yang
//
//  Created by niesiyang-worker on 2017/11/16.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTPOIDetailInfoViewController.h"
#import "HTMainPoiNavCtl.h"
#import "HTPOIDetailInfoHeaderView.h"

@interface HTPOIDetailInfoViewController ()<AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) AMapSearchAPI * searchApi;

@property (nonatomic, strong) NSMutableArray * topDataArray;
@property (nonatomic, strong) NSMutableArray<AMapPOI *> *dataArray;


@property (nonatomic,assign) NSInteger page;
@property (nonatomic,weak)   UITableView * tableView;
@end

@implementation HTPOIDetailInfoViewController

-(NSMutableArray<AMapPOI *> *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)topDataArray
{
    if (_topDataArray == nil) {
        _topDataArray = [NSMutableArray array];
    }
    return _topDataArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _page = 1;
        _searchApi = [[AMapSearchAPI alloc]init];
        _searchApi.delegate = self;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HTMainPoiNavCtl *nav = (HTMainPoiNavCtl *)self.navigationController;
    if ([nav isKindOfClass:[HTMainPoiNavCtl class]]) {
        nav.position = 1;
    }
}

-(void)setPoi:(AMapPOI *)poi
{
    _poi = poi;
    self.title = _poi.name;
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [HTColor ht_whiteColor];
    [self creatUI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:MainPoiPoint object:_poi];
}

-(void)creatUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    request.location       = [AMapGeoPoint locationWithLatitude:self.poi.location.latitude longitude:self.poi.location.longitude];
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.requireSubPOIs      = YES;
    request.page                = self.page;
    [HTProgressHUD LoadingShowMessage:self.poi.name andDetailMessage:@"正在搜索中..." forView:self.view];
    [self.searchApi AMapPOIAroundSearch:request];
}


#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.topDataArray.count;
    }
    else
    {
        return self.dataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_0"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_0"];
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell ht_setBottomLine];
        }
        if (indexPath.row>=self.dataArray.count) {
            cell.textLabel.text = @"";
            return cell;
        }
        AMapPOI *poi = self.dataArray[indexPath.row];
        cell.textLabel.text = poi.name;
        return cell;
    }
        

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 44;
    }
    else
    {
        return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        HTPOIDetailInfoHeaderView *view = [[HTPOIDetailInfoHeaderView alloc]init];
        [view configData:self.poi];
        return view;
    }
    else
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[HTColor textColor_333333] forState:UIControlStateNormal];
        [button setBackgroundColor:[HTColor ht_emptyColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setImage:[UIImage imageNamed:@"icon_near"] forState:UIControlStateNormal];
        [button setTitle:@"周边" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
        return button;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.poi.images.count>0)
        {
            return 200 + IphoneWidth*9/16;
        }
        else
        {
            return 200;
        }
    }
    else
    {
        return 25;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    HTMainPoiNavCtl *nav = (HTMainPoiNavCtl *)self.navigationController;
    if ([nav isKindOfClass:[HTMainPoiNavCtl class]]) {
        if (scrollView.contentOffset.y<=-140) {
            nav.position = 1;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMapPOI *poi = self.dataArray[indexPath.row];
    self.poi = poi;
    [[NSNotificationCenter defaultCenter]postNotificationName:MainPoiPoint object:poi];
    [tableView setContentOffset:CGPointMake(0.f, -50.f) animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
