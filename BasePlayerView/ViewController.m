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

@property (nonatomic, strong) UIView *playerBgView;
@property (nonatomic, strong) UIButton  *playBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[BasePlayerView shareInstance]];
    
    
    _playerBgView = [[UIView alloc]init];
    [self.view addSubview:_playerBgView];
    [_playerBgView addSubview:[BasePlayerView shareInstance]];
    
    [_playerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).with.offset(20.0);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(_playerBgView.mas_width).with.multipliedBy(9.0 / 16.0);
    }];
    [[BasePlayerView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_playerBgView.mas_left);
        make.top.equalTo(_playerBgView.mas_top);
        make.right.equalTo(_playerBgView.mas_right);
        make.bottom.equalTo(_playerBgView.mas_bottom);
    }];
    
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.backgroundColor = [UIColor grayColor];
    _playBtn.clipsToBounds = YES;
    _playBtn.layer.cornerRadius = 6.0;
    [_playBtn setTitle:@"Load Video" forState:UIControlStateNormal];
    [self.view addSubview:_playBtn];
    [_playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-80.0);
        make.width.mas_equalTo(120.0);
        make.height.mas_equalTo(34.0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenStatusBarChanged:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}



- (void)playBtnClicked{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *playUrl = [NSURL URLWithString:@"http://cache.m.iqiyi.com/dc/dt/mobile/20170612/2b/2d/c940390b0d91166bba05c36f90650ecf.m3u8?qypid=697607900_22&qd_src=5be6a2fdfe4f4a1a8c7b08ee46a18887&qd_tm=1497332264000&qd_ip=183.230.177.170&qd_sc=89916a98d845c38aecf15721e861da3d&mbd=f0f6c3ee5709615310c0f053dc9c65f2_5.9_1"];
        [BasePlayerView playWithUrl:playUrl withHeaderInfos:nil];
    });
}

- (void)screenStatusBarChanged:(NSNotification *)notifi{
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        _playBtn.hidden = NO;
        [_playerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top).with.offset(20.0);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(_playerBgView.mas_width).with.multipliedBy(9.0 / 16.0);
        }];
    }else{
        _playBtn.hidden = YES;
        [_playerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
