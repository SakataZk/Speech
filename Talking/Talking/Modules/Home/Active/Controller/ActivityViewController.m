//
//  ActivityViewController.m
//  Talking
//
//  Created by dllo on 16/9/21.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityModel.h"
#import "ActivityTableViewCell.h"
#import "ActiveInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "webViewViewController.h"

static NSString *const identifier = @"cell";
@interface ActivityViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *activityArray;
@property (nonatomic, strong) ActivityModel *nowActiveModel;

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *image;

@end

@implementation ActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityArray = [NSMutableArray array];
    self.nowActiveModel = [[ActivityModel alloc] init];
    [self GetActivity];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.y - self.navigationController.navigationBar.height) style:UITableViewStylePlain];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.rowHeight = self.view.height * 0.3f;
    [self.view addSubview:_tabelView];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.45)];
    _headerView.backgroundColor = [UIColor whiteColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_headerView addGestureRecognizer:tap];
    
    self.image = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    [_headerView addSubview:_image];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.02, self.view.width * 0.02, self.view.width * 0.2, self.view.width * 0.05)];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"主题活动";
    label.layer.cornerRadius = label.height / 2;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:label];

    _tabelView.tableHeaderView = _headerView;

}
- (void)GetActivity {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_uid] forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/activity/select_activities/v2?curPage=1&pageSize=20"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [NSArray arrayWithArray:[responseObject objectForKey:@"activities"]];
        for (NSDictionary *dic in array) {
            ActivityModel *model = [[ActivityModel alloc] initWithDic:dic];

            if (model.type == 2) {
                [_activityArray addObject:model];
            } else {
                _nowActiveModel = model;
                NSURL *url = [NSURL URLWithString:model.picture];
                [_image sd_setImageWithURL:url];
            }            
        }
        [_tabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40.f)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"     往期活动";
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    ActivityModel *model = _activityArray[indexPath.row];
    cell.imageUrl = model.picture;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    ActiveInfoViewController *activeInfoView = [[ActiveInfoViewController  alloc] init];
    activeInfoView.model = _activityArray[indexPath.row];
    activeInfoView.uid = _uid;
    activeInfoView.token = _token;
    [self.navigationController pushViewController:activeInfoView animated:YES];
}
- (void)tapAction {
    
    webViewViewController *webView = [[webViewViewController alloc] init];
    webView.activitying = _nowActiveModel.activityUrl;
    webView.text = _nowActiveModel.name;
    [self.navigationController pushViewController:webView animated:YES];
}

@end
