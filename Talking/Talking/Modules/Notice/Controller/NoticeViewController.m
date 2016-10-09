//
//  NoticeViewController.m
//  Talking
//
//  Created by dllo on 16/10/8.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "NoticeModel.h"
#import "AFAutoPurgingImageCache.h"



@interface NoticeViewController ()
<
UITableViewDataSource,
UITableViewDelegate
//NoticeTableViewCellDelegate
>
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tabelView;

@property (nonatomic, strong) NSMutableArray *noticeArray;

@property (nonatomic, assign) CGFloat cellRowHeight;

@property (nonatomic, strong) NSMutableArray *midArray;

@property (nonatomic, strong) NSMutableDictionary *cellDic;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.noticeArray = [[NSMutableArray alloc] init];
    self.midArray = [[NSMutableArray alloc] init];
    self.cellDic = [[NSMutableDictionary alloc] init];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height * 0.05, self.view.width, self.view.height * 0.08)];
    _titleLabel.userInteractionEnabled = YES;
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.text = @"人言通知";
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
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleLabel.y + _titleLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT - _titleLabel.y - _titleLabel.height)];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabelView];
   
    [self GetMessage];
    // Do any additional setup after loading the view.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeModel *model = _noticeArray[indexPath.row];
    CGFloat cellHeight = 0;
    NSString *text;
    if (model.contextType == 9 || model.contextType == 3) {
        text = model.message;
    }
    if (model.contextType == 4) {
        NSArray *array = [model.message componentsSeparatedByString:@";"];
        text = [array lastObject];
        cellHeight  = SCREEN_WIDTH * 0.3;
    }
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15.f]};
    CGSize textSize = CGSizeMake(SCREEN_WIDTH * 0.7, 1000);
    CGRect textRect = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    cellHeight = cellHeight + textRect.size.height + SCREEN_WIDTH * 0.15;

    
    return cellHeight;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _noticeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoticeModel *model = _noticeArray[indexPath.row];
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%ld",model.contextType]];
    
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%ld",model.contextType];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%ld",model.contextType]];
        [_tabelView registerClass:[NoticeTableViewCell class] forCellReuseIdentifier:identifier];
    }
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.noticeModel = model;
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_tabelView.contentOffset.y > _tabelView.contentSize.height - (SCREEN_HEIGHT - _titleLabel.y - _titleLabel.height)) {
        [self addMoreMessage];
    }
}

- (void)GetMessage {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/message/query_all_reply_sysmsg?to_uid=189186&limit=10"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_noticeArray.count > 0) {
            [_noticeArray removeAllObjects];
        }
        if (_midArray.count > 0) {
            [_midArray removeAllObjects];
        }
        NSArray *array = [responseObject objectForKey:@"messages"];
        NSLog(@"%ld",array.count);
        for (NSDictionary *dic in array) {
            NSDictionary *subDic = [dic objectForKey:@"message"];
            NoticeModel *model = [[NoticeModel alloc] initWithDic:subDic];
            [_midArray addObject:model.mid];
            [_noticeArray addObject:model];
        }
        [_tabelView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
    }];
}



- (void)addMoreMessage {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/message/query_all_reply_sysmsg?to_uid=189186&last_mid=%@&limit=10",[_midArray lastObject]];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = [responseObject objectForKey:@"messages"];
        for (NSDictionary *dic in array) {
            NSDictionary *subDic = [dic objectForKey:@"message"];
            NoticeModel *model = [[NoticeModel alloc] initWithDic:subDic];
            NoticeModel *lastModel = [_noticeArray lastObject];
            if (![model.mid isEqualToNumber:lastModel.mid]) {
                [_midArray addObject:model.mid];
                [_noticeArray addObject:model];
            }else {
                NSLog(@"加载完了");
            }
            
        }

        [_tabelView reloadData];
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
