
//
//  SearchViewController.m
//  Talking
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SearchViewController.h"
#import "MySearchBar.h"
#import "ResultsModel.h"
#import "ResultTableViewCell.h"
#import "UserViewController.h"
#import "AlbumViewController.h"
#import "HotTopicModel.h"

static NSString *const identifier = @"cell";
@interface SearchViewController ()
<
UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, retain) MySearchBar *searchBar;

@property (nonatomic, strong) UITableView *tabelView;

@property (nonatomic, strong) NSString *searchString;


@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIButton *albumButton;
@property (nonatomic, strong) UILabel *albumLabel;
@property (nonatomic, strong) UIButton *userButton;
@property (nonatomic, strong) UILabel *userLabel;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) NSInteger AllCount;
@property (nonatomic, assign) NSInteger AlbumCount;
@property (nonatomic, assign) NSInteger UserCount;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *albumArray;
@property (nonatomic, strong) NSMutableArray *userArray;

@property (nonatomic, strong) AlbumViewController *albumView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = [[NSMutableArray alloc] init];
    self.allArray = [[NSMutableArray alloc] init];
    self.albumArray = [[NSMutableArray alloc] init];
    self.userArray = [[NSMutableArray alloc] init];
    self.AllCount = 1;
    self.AlbumCount = 1;
    self.UserCount = 1;

    
    
    [self creatSearchBar];
    [self creatButton];
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, _allLabel.y + _allLabel.height, SCREEN_WIDTH, SCREEN_HEIGHT - _allLabel.y - _allLabel.height) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.rowHeight = SCREEN_HEIGHT * 0.1;
    _tabelView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tabelView];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_allButton.selected) {
        return _allArray.count;
    }
    if (_albumButton.selected) {
        return _albumArray.count;
    }
        return _userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_allButton.selected) {
        ResultsModel *model = _allArray[indexPath.row];
        cell.resultModel = model;
    }
    if (_albumButton.selected) {
        ResultsModel *model = _albumArray[indexPath.row];
        cell.resultModel = model;
    }
    if (_userButton.selected) {
        ResultsModel *model = _userArray[indexPath.row];
        cell.resultModel = model;
    }

   
    return cell;
}


- (void)creatSearchBar {

    self.searchBar = [[MySearchBar alloc] init];
    _searchBar.frame = CGRectMake(5, self.view.height * 0.06, self.view.width *0.8, self.view.height * 0.06);
    _searchBar.delegate = self;
    
    [_searchBar addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:_searchBar];
    
    UIButton * returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setTitle:@"取消" forState:UIControlStateNormal];
    returnButton.frame = CGRectMake(_searchBar.x + _searchBar.width, _searchBar.y, self.view.width * 0.2 - _searchBar.x, _searchBar.y);
    returnButton.backgroundColor = [UIColor clearColor];
    [returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:returnButton];
    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];

}

- (void)creatButton {
    
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_allButton setTitle:@"所有" forState:UIControlStateNormal];
    [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _allButton.frame = CGRectMake(0, self.view .height * 0.15, self.view .width / 3, self.view.height * 0.06);
    [self.view addSubview:_allButton];
    [_allButton setSelected:YES];
    [_allButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get?curPage=%ld&keyword=%@&pageSize=10",_AllCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getResult:_url];
        
        _allButton.selected = YES;
        _albumButton.selected = NO;
        _userButton.selected = NO;
        [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_albumButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_userButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _allLabel.backgroundColor = [UIColor yellowColor];
        _albumLabel.backgroundColor = [UIColor lightGrayColor];
        _userLabel.backgroundColor = [UIColor lightGrayColor];
        
    }];
    
    self.allLabel = [[UILabel alloc] initWithFrame:CGRectMake(_allButton.x, _allButton.y + _allButton.height, _allButton.width, 1)];
    _allLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_allLabel];

    
    self.albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_albumButton setTitle:@"言集" forState:UIControlStateNormal];
    [_albumButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _albumButton.frame = CGRectMake(_allButton.width, _allButton.y, _allButton.width, _allButton.height);
    [_albumButton setSelected:NO];
    [self.view addSubview:_albumButton];
    [_albumButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/album?curPage=%ld&keyword=%@&pageSize=10",_AlbumCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getResult:_url];
        
        _allButton.selected = NO;
        _userButton.selected = NO;
        _albumButton.selected = YES;
        [_albumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_userButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _allLabel.backgroundColor = [UIColor lightGrayColor];
        _albumLabel.backgroundColor = [UIColor yellowColor];
        _userLabel.backgroundColor = [UIColor lightGrayColor];
        
    }];
    
    self.albumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_albumButton.x, _allLabel.y, _allLabel.width, _allLabel.height)];
    _albumLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_albumLabel];
    
    
    self.userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_userButton setTitle:@"用户" forState:UIControlStateNormal];
    [_userButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _userButton.frame = CGRectMake(_allButton.width * 2, _allButton.y, _allButton.width, _allButton.height);
    [_userButton setSelected:NO];
    [self.view addSubview:_userButton];
    [_userButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/user?curPage=%ld&keyword=%@&pageSize=10",_UserCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getResult:_url];

        _allButton.selected = NO;
        _albumButton.selected = NO;
        _userButton.selected = YES;
        [_allButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_albumButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_userButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _allLabel.backgroundColor = [UIColor lightGrayColor];
        _albumLabel.backgroundColor = [UIColor lightGrayColor];
        _userLabel.backgroundColor = [UIColor yellowColor];
    }];
    
    self.userLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userButton.x, _allLabel.y, _allLabel.width, _allLabel.height)];
    _userLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_userLabel];
    
}


- (void)textFieldEditChanged:(UITextField *)textField {
    if (_allArray.count > 0) {
        [_allArray removeAllObjects];
    }
    if (_albumArray.count > 0) {
        [_albumArray removeAllObjects];
    }
    if (_userArray.count > 0) {
        [_userArray removeAllObjects];
    }
    self.searchString = [textField text];
    if (_allButton.selected) {
        _AllCount = 1;
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get?curPage=%ld&keyword=%@&pageSize=10",_AllCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [_allArray addObjectsFromArray:_array];
    }
    
    if (_albumButton.selected) {
        _AlbumCount = 1;
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/album?curPage=%ld&keyword=%@&pageSize=10",_AlbumCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [_albumArray addObjectsFromArray:_array];
    }
    
    if (_userButton.selected) {
        _UserCount = 1;
        _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/user?curPage=%ld&keyword=%@&pageSize=10",_UserCount,_searchString];
        _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       
        [_userArray addObjectsFromArray:_array];
    }
    [self getResult:_url];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    if (_allButton.selected) {
        if (_tabelView.contentOffset.y > _tabelView.rowHeight * _allArray.count - (SCREEN_HEIGHT - _allLabel.y - _allLabel.height)) {
                _AllCount++;
                _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get?curPage=%ld&keyword=%@&pageSize=10",_AllCount,_searchString];
                _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self getResult:_url];
        }
    }
    
    if (_albumButton.selected) {
        if (_tabelView.contentOffset.y > _tabelView.rowHeight * _albumArray.count - (SCREEN_HEIGHT - _allLabel.y - _allLabel.height)) {
            _AlbumCount++;
            _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/album?curPage=%ld&keyword=%@&pageSize=10",_AlbumCount,_searchString];
            _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getResult:_url];
    }
}
    if (_userButton.selected) {
        if (_tabelView.contentOffset.y > _tabelView.rowHeight * _userArray.count - (SCREEN_HEIGHT - _allLabel.y - _allLabel.height)) {

            _UserCount++;
            NSLog(@"%ld",_userArray.count);
            NSLog(@"%ld",_UserCount);
            _url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/search/get/user?curPage=%ld&keyword=%@&pageSize=10",_UserCount,_searchString];
            _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getResult:_url];
        }
    }


}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

- (void)getResult:(NSString *)url {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_array.count > 0) {
            [_array removeAllObjects];
        }
        if ([[responseObject objectForKey:@"msg"] isEqualToString: @"搜索成功，返回内容"]) {
            NSArray *resultsArray = [responseObject objectForKey:@"results"];
            
            for (NSDictionary *dic in resultsArray) {
                ResultsModel *resultModel = [[ResultsModel alloc] initWithDic:dic];
                [_array addObject:resultModel];
            }
            if (_allButton.selected) {
                [_allArray addObjectsFromArray:_array];
            }
            if (_albumButton.selected) {
                [_albumArray addObjectsFromArray:_array];
            }
            if (_userButton.selected) {
                [_userArray addObjectsFromArray:_array];
            }
        }
        [_tabelView reloadData];
    }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error : %@",error);
         }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_allButton.selected) {
        
        ResultsModel *model = _allArray [indexPath.row];
        if (model.type == 2) {
            UserViewController *userView = [[UserViewController alloc] init];
            userView.uid = model.allid;
            [self.navigationController pushViewController:userView animated:YES];
        } else {
            self.albumView = [[AlbumViewController alloc] init];
            [self getAlbumInfo:model.allid];
            
            [self.navigationController pushViewController:_albumView animated:YES];
        }
        
    }
    if (_albumButton.selected) {
        
    }
    if (_userButton.selected) {
      
        
    }

}

- (void)getAlbumInfo:(NSNumber *)aid {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"189186" forHTTPHeaderField:@"X-User"];
    [manager.requestSerializer setValue:@"A991B7D59DACB35A141ED180BF3EA6534F2B5E4FD8BAE126DF9BDAB620ABB39BDB73F66EB26933318FF792C0DDCF74D2C8C6D1E5978B351A70545ED860B91D8A" forHTTPHeaderField:@"X-AuthToken"];
    [manager.requestSerializer setValue:@"j8slb29fbalc83pna2af2c2954hcw65" forHTTPHeaderField:@"X-ApiKey"];
    NSString *url = [NSString stringWithFormat:@"http://app.ry.api.renyan.cn/rest/auth/album/single_by_id?uid=189186&aid=%@",aid];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *albumDic = [responseObject objectForKey:@"album"];
        HotTopicModel *hot = [[HotTopicModel alloc]initWithDic:albumDic];
        _albumView.hotTopic = hot;
    }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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
