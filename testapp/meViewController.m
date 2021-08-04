//
//  meViewController.m
//  testapp
//
//  Created by lichun on 2021/7/30.
//

#import "meViewController.h"

@interface meViewController ()

@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setTitle:@"clicked" forState:UIControlStateHighlighted];
    [btn setBackgroundColor:[UIColor greenColor]];

    btn.frame = CGRectMake(100, 100, 100, 100);
        
    [self.view addSubview:btn];
}

@end
