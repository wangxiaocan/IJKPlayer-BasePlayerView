//
//  PlayerBottomControl.m
//  BasePlayerView
//
//  Created by xiaocan on 2017/6/14.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import "PlayerBottomControl.h"
#import "BasePlayerView.h"
#import "Masonry.h"

@interface PlayerBottomControl()

@property (nonatomic, strong) UIImageView   *playImage;
@property (nonatomic, strong) UIButton      *playBtn;
@property (nonatomic, strong, readwrite) UISlider      *progressSliderView;
@property (nonatomic, strong) UILabel       *curentPlayTime;
@property (nonatomic, strong) UILabel       *videoDurationLabel;

@property (nonatomic, assign) double currentPlayTime;
@property (nonatomic, assign) double durationTime;


@end

@implementation PlayerBottomControl

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        _playImage = [[UIImageView alloc] init];
        _playImage.image = [UIImage imageNamed:@"player_play"];
        [self addSubview:_playImage];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_playBtn];
        [_playBtn addTarget:self action:@selector(playBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _curentPlayTime = [[UILabel alloc]init];
        _curentPlayTime.text = @"00:00";
        _curentPlayTime.font = [UIFont systemFontOfSize:13.0];
        _curentPlayTime.textColor = [UIColor whiteColor];
        _curentPlayTime.textAlignment = NSTextAlignmentCenter;
        _curentPlayTime.numberOfLines = 1;
        [self addSubview:_curentPlayTime];
        
        _progressSliderView = [[UISlider alloc]init];
        [_progressSliderView setThumbImage:[UIImage imageNamed:@"touch"] forState:UIControlStateNormal];
        [self addSubview:_progressSliderView];
        
        _videoDurationLabel = [[UILabel alloc]init];
        _videoDurationLabel.text = @"00:00";
        _videoDurationLabel.font = [UIFont systemFontOfSize:13.0];
        _videoDurationLabel.textColor = [UIColor whiteColor];
        _videoDurationLabel.textAlignment = NSTextAlignmentCenter;
        _videoDurationLabel.numberOfLines = 1;
        [self addSubview:_videoDurationLabel];
        
        
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(_playBtn.mas_height);
        }];
        
        [_playImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_playBtn.mas_left).with.offset(5.0);
            make.top.equalTo(_playBtn.mas_top).with.offset(5.0);
            make.bottom.equalTo(_playBtn.mas_bottom).with.offset(-5.0);
            make.right.equalTo(_playBtn.mas_right).with.offset(-5.0);
        }];
        
        [_curentPlayTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_playBtn.mas_right);
        }];
        
        [_progressSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(_curentPlayTime.mas_right).with.offset(5.0);
            make.right.equalTo(_videoDurationLabel.mas_left).with.offset(-5.0);
        }];
        
        [_videoDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).with.offset(-5.0);
        }];
        
        
        [_progressSliderView addTarget:self action:@selector(didSliderTouchDown) forControlEvents:UIControlEventTouchDown];
        [_progressSliderView addTarget:self action:@selector(didSliderTouchCancel) forControlEvents:UIControlEventTouchCancel];
        [_progressSliderView addTarget:self action:@selector(didSliderTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [_progressSliderView addTarget:self action:@selector(didSliderTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_progressSliderView addTarget:self action:@selector(didSliderValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)playBtnClicked{
    [BasePlayerView changePlayStatus];
}

- (void)didSliderTouchDown{
    _isDragingSlider = YES;
}

- (void)didSliderTouchCancel{
    _isDragingSlider = NO;
}

- (void)didSliderTouchUpOutside{
    _isDragingSlider = NO;
}

- (void)didSliderTouchUpInside{
    [BasePlayerView setCurrentPlayBackTime:_durationTime * _progressSliderView.value];
    _isDragingSlider = NO;
}

- (void)didSliderValueChanged{
    NSInteger curTime = (int)(_progressSliderView.value * _durationTime);
    NSInteger hour = (int)(curTime / 3600);
    NSInteger mint = (int)(curTime % 3600 / 60);
    NSInteger seconds = (int)(curTime % 3600 % 60);
    if (hour > 0) {
        _curentPlayTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)mint,(long)seconds];
    }else{
        _curentPlayTime.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)mint,(long)seconds];
    }
}

- (void)resume{
    _isDragingSlider = NO;
    _progressSliderView.value = 0.f;
}

- (void)setPlayProgress:(CGFloat)progress{
    if (_isDragingSlider) return;
    _progressSliderView.value = progress;
}

- (void)setPlayStatus:(BOOL)isPlaying{
    if (isPlaying) {
        _playImage.image = [UIImage imageNamed:@"player_pause"];
    }else{
        _playImage.image = [UIImage imageNamed:@"player_play"];
    }
}

- (void)setCurrentPlayTime:(double)currentPlayTime andDuration:(double)durationTime{
    if (_isDragingSlider) return;
    _currentPlayTime = currentPlayTime;
    _durationTime = durationTime;
    
    NSInteger curTime = currentPlayTime;
    NSInteger totalTime = durationTime;
    
    
    NSInteger hour = (int)(curTime / 3600);
    NSInteger mint = (int)(curTime % 3600 / 60);
    NSInteger seconds = (int)(curTime % 3600 % 60);
    if (hour > 0) {
        _curentPlayTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)mint,(long)seconds];
    }else{
       _curentPlayTime.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)mint,(long)seconds];
    }
    
    
    hour = (int)(totalTime / 3600);
    mint = (int)(totalTime % 3600 / 60);
    seconds = (int)(totalTime % 3600 % 60);
    if (hour > 0) {
        _videoDurationLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)mint,(long)seconds];
    }else{
        _videoDurationLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)mint,(long)seconds
                                    ];
    }
    
}

@end
