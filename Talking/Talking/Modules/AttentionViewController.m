//
//  AttentionViewController.m
//  Talking
//
//  Created by dllo on 16/10/10.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "AttentionViewController.h"
#import "attentionModel.h"
#import "attentionTableViewCell.h"


static NSString *const identifier = @"attentionCell";
@interface AttentionViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>


@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *attentionArray;

@property (nonatomic, strong) NSMutableArray *sidArray;
@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.attentionArray = [[NSMutableArray alloc] init];
    self.sidArray = [[NSMutableArray alloc] init];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.05, self.view.width, self.view.height * 0.08)];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.text = @"关注";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.frame = CGRectMake(self.view.width * 0.055, 0, self.view.width * 0.055, _titleLabel.height / 3);
    returnButton.centerY = _titleLabel.centerY;
    [returnButton setImage:[UIImage imageNamed:@"darkReturn"] forState:UIControlStateNormal];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:returnButton];
    
    [self GetAttention];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleLabel.y + _titleLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT - (_titleLabel.y + _titleLabel.height))];
    _tableView.rowHeight = _titleLabel.height;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _attentionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    attentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[attentionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = _attentionArray[indexPath.row];

    return cell;
}






- (void)GetAttention {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_uid] forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/subscribe/new/query_all?uid=%@&limit=10",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_attentionArray.count > 0) {
            [_attentionArray removeAllObjects];
        }
        if (_sidArray.count > 0) {
            [_sidArray removeAllObjects];
        }
        NSArray *array = [responseObject objectForKey:@"subscribes"];
        for (NSDictionary *dic in array) {
            attentionModel *model = [[attentionModel alloc] initWithDic:dic];
            [_sidArray addObject:model.sid];
            [_attentionArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}
- (void)addMoreAttention {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_uid] forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/subscribe/new/query_all?uid=%@&limit=10&last_sid=%@",_uid,[_sidArray lastObject]];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {        
        NSArray *array = [responseObject objectForKey:@"subscribes"];
        for (NSDictionary *dic in array) {
            attentionModel *lastModel = [_attentionArray lastObject];
            attentionModel *model = [[attentionModel alloc] initWithDic:dic];
            if (! [model.sid isEqualToNumber:lastModel.sid]) {
                [_sidArray addObject:model.sid];
                [_attentionArray addObject:model];
            } else  {
                NSLog(@"加载完了");
            }
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_tableView.contentOffset.y > _tableView.contentSize.height - (SCREEN_HEIGHT - _titleLabel.y - _titleLabel.height)) {
        [self addMoreAttention];
    }
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
