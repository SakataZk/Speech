//
//  webViewViewController.h
//  Talking
//
//  Created by dllo on 16/10/12.
//  Copyright © 2016年 Sakata_ZK. All rights reserved.
//

#import "SpBaseViewController.h"

@interface webViewViewController : SpBaseViewController

<
UIWebViewDelegate
>
{
    UIWebView *webView;
}

@property (nonatomic, strong) NSString *activitying;

@property (nonatomic, strong) NSString *text;
@end
