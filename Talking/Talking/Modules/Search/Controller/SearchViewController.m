
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
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBarHidden = YES;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.1)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    
    UISearchBar *seachBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, topView.height / 3, self.view.width - 10, topView.height / 3 * 2)];
    seachBar.placeholder = @"搜索言集. 用户";
    seachBar.delegate = self;
    
    [seachBar setShowsCancelButton:YES animated:NO];
    for(UIView *view in [[[seachBar subviews]lastObject]subviews] ) {
        
        if([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
        }
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
        UITextField *searchField = [seachBar valueForKey:@"_searchField"];
        [searchField setBackgroundColor:[UIColor colorWithRed:0.9098 green:0.9059 blue:0.9176 alpha:1.0]];
        }
        if([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
        UIButton *cancelButton = [seachBar valueForKey:@"_cancelButton"];
            [cancelButton setTitle:@"取消"forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    [self.view addSubview:seachBar];



}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"开始输入搜索内容");

  
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"输入搜索内容完毕");
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
