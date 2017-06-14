//
//  BasePlayerView.h
//  BasePlayerView
//
//  Created by xiaocan on 2017/6/13.
//  Copyright © 2017年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
@class IJKMediaControl;

@interface BasePlayerView : UIView

@property(nonatomic, strong, readonly) NSURL *url;
@property(nonatomic, strong, readonly) id<IJKMediaPlayback> player;
@property(nonatomic, assign, readonly) BOOL isPlaying;
@property(nonatomic, assign, readonly) BOOL lastPlayStatus; /**< YES：play，NO：pause */


+ (void)pause;

+ (void)resume;

+ (void)play;

+ (void)shutDown;

/** 播放状态互切 */
+ (void)changePlayStatus;

//set player seeking time
+ (void)setCurrentPlayBackTime:(double)playTime;






/** 播放单例 */
+ (instancetype)shareInstance;

/** 设置播放链接并播放 */
+ (void)playWithUrl:(NSURL *)playUrl withHeaderInfos:(NSDictionary *)headerInfo;

@end
