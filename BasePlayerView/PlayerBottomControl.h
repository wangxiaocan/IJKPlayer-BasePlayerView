//
//  PlayerBottomControl.h
//  BasePlayerView
//
//  Created by xiaocan on 2017/6/14.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 暂停、播放、快进快退 */
@interface PlayerBottomControl : UIView

- (void)resume;

- (void)setPlayProgress:(CGFloat)progress;

- (void)setPlayStatus:(BOOL)isPlaying;

- (void)setCurrentPlayTime:(double)currentPlayTime andDuration:(double)durationTime;

@end
