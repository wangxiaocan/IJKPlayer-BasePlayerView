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

@property (nonatomic, strong) UITextField       *urlInputView;
@property (nonatomic, strong) UIButton          *playBtn;

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
    
    
    _urlInputView = [[UITextField alloc]init];
    _urlInputView.clearButtonMode = UITextFieldViewModeAlways;
    _urlInputView.borderStyle = UITextBorderStyleRoundedRect;
    _urlInputView.placeholder = @" 请输入播放链接";
    _urlInputView.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:_urlInputView];
    
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.backgroundColor = [UIColor grayColor];
    _playBtn.clipsToBounds = YES;
    _playBtn.layer.cornerRadius = 6.0;
    [_playBtn setTitle:@"Load Video" forState:UIControlStateNormal];
    [self.view addSubview:_playBtn];
    [_playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_urlInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playerBgView.mas_bottom).with.offset(40.0);
        make.left.equalTo(self.view.mas_left).with.offset(10.0);
        make.right.equalTo(self.view.mas_right).with.offset(-10.0);
        make.height.mas_equalTo(34.0);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_urlInputView.mas_bottom).with.offset(20.0);
        make.width.mas_equalTo(120.0);
        make.height.mas_equalTo(34.0);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenStatusBarChanged:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}



- (void)playBtnClicked{
    if (_urlInputView.text.length > 0) {
        [BasePlayerView playWithUrl:[NSURL URLWithString:_urlInputView.text] withHeaderInfos:nil];
    }
}

- (void)screenStatusBarChanged:(NSNotification *)notifi{
    if ([_urlInputView isFirstResponder]) {
        [_urlInputView resignFirstResponder];
    }
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        _playBtn.hidden = NO;
        _urlInputView.hidden = NO;
        [_playerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top).with.offset(20.0);
            make.right.equalTo(self.view.mas_right);
            make.height.equalTo(_playerBgView.mas_width).with.multipliedBy(9.0 / 16.0);
        }];
    }else{
        _playBtn.hidden = YES;
        _urlInputView.hidden = YES;
        [_playerBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_urlInputView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
