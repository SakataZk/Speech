//
//  CommentViewController.m
//  Talking
//
//  Created by dllo on 16/10/9.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"

static NSString *const identifier = @"cell";
@interface CommentViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tabelView;

@property (nonatomic, strong) NSMutableArray *commentArray;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commentArray = [[NSMutableArray alloc] init];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.05, self.view.width, self.view.height * 0.08)];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.text = @"评论";
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
    [self GetComment];
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleLabel.y + _titleLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT - (_titleLabel.y + _titleLabel.height))];
    _tabelView.rowHeight = SCREEN_HEIGHT * 0.25;
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabelView];
    
    
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _commentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.commentModel = _commentArray[indexPath.row];
    return cell;

}

- (void)GetComment {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",_uid] forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:_token forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/sysmsg/query_all_comment?uid=%@&limit=10",_uid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_commentArray.count > 0) {
            [_commentArray removeAllObjects];
        }
        if (![[responseObject objectForKey:@"msg"] isEqualToString:@"查询成功，结果为空"]) {
            NSArray *array = [responseObject objectForKey:@"comments"];
            for (NSDictionary *dic in array) {
                CommentModel *model = [[CommentModel alloc] initWithDic:dic];
                [_commentArray addObject:model];
                [_tabelView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];

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
