中移物联网有限公司 OneNET iOS Player SDK

### 环境准备
- Xcode 11
- CPU arm64

### 特性

- 支持直播、点播
- 支持RTMP、RTMPE、HLS和HTTPS播放
- 支持RTMP，RMPE直播的语音推送
- 支持播放截屏
- 优化RTMP首屏打开时间
- 优化可变帧率软解码流程，可根据帧率动态调整解码线程数

### api

- (void)play;
- (void)pause;
- (void)stop;
- (void)continuePlay;
- (void)seekTo:(NSTimeInterval)time;
- (void)replay;

- (void)finishPlay;
- (void)shutdown;
- (void)destroy;

- (void)startPushingAudio;
- (void)stopPushingAudio;

### License
```
Copyright (c) 2018 cmiot
```
