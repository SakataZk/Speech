
//
//  SearchViewController.m
//  Talking
//
//  Created by dllo on 16/9/28.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
<
UISearchBarDelegate
>
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor redColor];

    
    
    
    
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
