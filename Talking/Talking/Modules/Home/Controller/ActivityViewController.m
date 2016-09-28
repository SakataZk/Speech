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

static NSString *const identifier = @"cell";
@interface ActivityViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *activityArray;

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, assign) long int timeNumber;
@end

@implementation ActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityArray = [NSMutableArray array];
    
    [self GetActivity];
    self.view.backgroundColor = [UIColor redColor];
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.navigationController.navigationBar.y - self.navigationController.navigationBar.height) style:UITableViewStylePlain];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.rowHeight = self.view.height * 0.3f;
    [self.view addSubview:_tabelView];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.45)];
    _headerView.backgroundColor = [UIColor cyanColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.02, self.view.width * 0.02, self.view.width * 0.2, self.view.width * 0.05)];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"主题活动";
    label.layer.cornerRadius = label.height / 2;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:label];

    _tabelView.tableHeaderView = _headerView;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    self.timeNumber = [timeString longLongValue];
    
    
//    NSLog(@"%ld",_timeNumber);

}
- (void)GetActivity {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39B589F205ECF3D7791C8CE287E9B087D6BEF48CA1E5A3FE3FC6C968A08F7642843" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/activity/select_activities/v2?curPage=1&pageSize=20"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [NSArray arrayWithArray:[responseObject objectForKey:@"activities"]];
        for (NSDictionary *dic in array) {
            ActivityModel *model = [[ActivityModel alloc] initWithDic:dic];
            long int start = [model.startTime longLongValue] / 1000;
            long int end = [model.endTime longLongValue] / 1000;
            if (_timeNumber > start && _timeNumber > end) {
                [_activityArray addObject:model];
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
    [self.navigationController pushViewController:activeInfoView animated:YES];
    NSLog(@"%ld",indexPath.row);

}


@end
