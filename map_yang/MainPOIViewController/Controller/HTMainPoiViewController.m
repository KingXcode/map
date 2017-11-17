//
//  HTMainPoiViewController.m
//  map_yang
//
//  Created by niesiyang on 2017/11/12.
//  Copyright © 2017年 niesiyang. All rights reserved.
//

#import "HTMainPoiViewController.h"
#import <Masonry.h>
#import "HTMainPoiNavCtl.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "HTPoiSearchItemModel.h"
#import "HTPOIDetailInfoViewController.h"

@interface HTMainPoiViewController ()<UISearchBarDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UISearchBar * searchBar;
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) AMapSearchAPI * searchApi;

@property (nonatomic,strong) RLMResults<HTPoiSearchItemModel *> * dataArray;
@property (nonatomic, strong) NSMutableArray<AMapTip *> *tips;

@property (nonatomic,assign) BOOL isSearch;

@end

@implementation HTMainPoiViewController

-(NSMutableArray *)tips
{
    if (_tips == nil ) {
        _tips = [NSMutableArray array];
    }
    return _tips;
}


-(RLMResults<HTPoiSearchItemModel *> *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [HTPoiSearchItemModel allObjects];
    }
    return _dataArray;
}


-(AMapSearchAPI *)search
{
    if (_searchApi == nil) {
        _searchApi = [[AMapSearchAPI alloc]init];
        _searchApi.delegate = self;
    }
    return _searchApi;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [HTColor ht_whiteColor];

    [self creatUI];
    
    //恶心?----高德的问题?
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = @" ";
    tips.cityLimit = YES;
    [self.search AMapInputTipsSearch:tips];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(topFullScreen) name:@"topFullScreen" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(halfscreen) name:@"halfscreen" object:nil];

}



-(void)topFullScreen
{
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset([UIApplication sharedApplication].statusBarFrame.size.height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)halfscreen
{
    [self.searchBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(10);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)creatUI
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    searchBar.barTintColor = [HTColor ht_emptyColor];
    searchBar.layer.borderWidth = 0;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchBar];
    self.searchBar  = searchBar;
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.backgroundColor = [HTColor ht_whiteColor];
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IphoneWidth, 0.1)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IphoneWidth, 0.1)];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.delaysContentTouches = NO;
    self.tableView = tableView;
    [self.view addSubview:tableView];

    
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(56));
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}




#pragma -mark-  tableview代理
#pragma -mark- tableView delegate  datasuoce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch)
    {
        return self.tips.count;
    }
    else
    {
        return self.dataArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [HTColor textColor_333333];
        cell.detailTextLabel.textColor = [HTColor textColor_999999];
    }
    if (self.isSearch)
    {
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        AMapTip *tips = self.tips[indexPath.row];
        cell.textLabel.text = tips.name;
        cell.detailTextLabel.text = tips.address;
    }
    else
    {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        HTPoiSearchItemModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.address;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch)
    {
        return 44;
    }
    else
    {
        return 77;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSearch)
    {
        AMapTip *tips = self.tips[indexPath.row];
        NSString *query = [NSString stringWithFormat:@"uid = '%@' AND name = '%@'",tips.uid,tips.name];
        RLMResults<HTPoiSearchItemModel *> *items = [HTPoiSearchItemModel objectsWhere:query];
        HTPoiSearchItemModel *model = [[HTPoiSearchItemModel alloc]init];
        model.address = tips.address;
        model.city = [HTMapManager sharedManager].currentCity;
        model.longitude = tips.location.longitude;
        model.latitude  = tips.location.latitude;
        model.uid = tips.uid;
        model.name = tips.name;
        model.adcode = tips.adcode;
        model.district = tips.district;
        [self searchPOIKeywords:model];
        if (items.count<=0) {
            [[HTDataBaseManager sharedManager].realm beginWriteTransaction];
            [[HTDataBaseManager sharedManager].realm addObject:model];
            [[HTDataBaseManager sharedManager].realm commitWriteTransaction];
            self.dataArray = [HTPoiSearchItemModel allObjects];
        }
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            HTPoiSearchItemModel *model = self.dataArray[indexPath.row];
            [self searchPOIKeywords:model];
        });
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        return NO;
    }
    else
    {
        return YES;
    }
}

-(NSArray<UITableViewRowAction *>* )tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action_0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        HTPoiSearchItemModel *model = self.dataArray[indexPath.row];
        [[HTDataBaseManager sharedManager].realm beginWriteTransaction];
        [[HTDataBaseManager sharedManager].realm deleteObject:model];
        [[HTDataBaseManager sharedManager].realm commitWriteTransaction];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    return @[action_0];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[HTColor textColor_666666] forState:UIControlStateNormal];
    [button setBackgroundImage:[HTTools ht_createImageWithColor:[HTColor ht_emptyColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[HTTools ht_createImageWithColor:[HTColor textColor_999999]] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"清空所有数据" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    return button;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
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


-(void)searchPOIKeywords:(HTPoiSearchItemModel *)model
{
    [HTProgressHUD LoadingShowMessage:model.name andDetailMessage:@"正在搜索中..." forView:self.view];
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc]init];
    request.keywords            = model.name;
    request.city                = [HTMapManager sharedManager].currentCity;
    request.requireExtension    = YES;
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    request.location = [AMapGeoPoint locationWithLatitude:model.latitude longitude:model.longitude];
    [self.searchApi AMapPOIKeywordsSearch:request];
}

#pragma -mark-  搜索代理
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.isSearch = NO;
    HTMainPoiNavCtl *nav = (HTMainPoiNavCtl *)self.navigationController;
    if ([nav isKindOfClass:[HTMainPoiNavCtl class]]) {
        nav.position = 1;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    HTMainPoiNavCtl *nav = (HTMainPoiNavCtl *)self.navigationController;
    if ([nav isKindOfClass:[HTMainPoiNavCtl class]]) {
        nav.position = 0;
    }
    [searchBar setShowsCancelButton:YES animated:YES];

    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [self.tips removeAllObjects];
        self.isSearch = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
    }
    self.isSearch = YES;
    [self.tableView reloadData];
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = searchText;
    tips.city     = [HTMapManager sharedManager].currentCity;
    tips.cityLimit = YES;
    [self.search AMapInputTipsSearch:tips];
}




#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]]) {
        [HTProgressHUD HiddenForView:self.view];
    }
    NSLog(@"Error: %@", error);
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [HTProgressHUD HiddenForView:self.view];
    if (response.pois.count == 0)
    {
        return;
    }
    AMapPOI *poi = response.pois.firstObject;
    HTPOIDetailInfoViewController *vc = [[HTPOIDetailInfoViewController alloc]init];
    vc.poi = poi;
    [self.navigationController pushViewController:vc animated:YES];
    self.isSearch = NO;
    [self.tableView reloadData];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.count == 0)
    {
        return;
    }
    [self.tips setArray:response.tips];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 HTPoiSearchItemModel *model = [[HTPoiSearchItemModel alloc]init];
 model.address = searchBar.text;
 RLMRealm *realm = [RLMRealm defaultRealm];
 [realm beginWriteTransaction];
 [realm addObject:model];
 [realm commitWriteTransaction];
*/

@end
