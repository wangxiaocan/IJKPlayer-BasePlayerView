//
//  ViewController.m
//  BasePlayerView
//
//  Created by xiaocan on 2017/6/13.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import "ViewController.h"
#import "BasePlayerView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[BasePlayerView shareInstance]];
    CGRect playFrame = [BasePlayerView shareInstance].frame;
    playFrame.origin.y = 20.0;
    [BasePlayerView shareInstance].frame = playFrame;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor grayColor];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 6.0;
    [btn setTitle:@"Load Video" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(playBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-80.0);
        make.width.mas_equalTo(120.0);
        make.height.mas_equalTo(34.0);
    }];
}

- (void)playBtn{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *playUrl = [NSURL URLWithString:@"http://cache.m.iqiyi.com/dc/dt/mobile/20170612/2b/2d/c940390b0d91166bba05c36f90650ecf.m3u8?qypid=697607900_22&qd_src=5be6a2fdfe4f4a1a8c7b08ee46a18887&qd_tm=1497332264000&qd_ip=183.230.177.170&qd_sc=89916a98d845c38aecf15721e861da3d&mbd=f0f6c3ee5709615310c0f053dc9c65f2_5.9_1"];
        [BasePlayerView playWithUrl:playUrl withHeaderInfos:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
