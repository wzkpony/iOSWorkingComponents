//
//  OtherModel.h
//  Text
//
//  Created by 王正魁 on 14-7-4.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import<AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AudioToolbox/AudioToolbox.h>
//#include "lame.h"
@interface AudioMethod : NSObject<AVAudioPlayerDelegate,AVAudioRecorderDelegate,NSURLConnectionDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
   
}
@property(nonatomic,strong)AVAudioRecorder* recorder;
@property(nonatomic,strong) AVAudioPlayer* player;
@property(nonatomic,copy)void(^blockForDidFinishAVAudioPlayer)(AVAudioPlayer* player,BOOL flag);
@property(nonatomic,copy)void(^blockForRecorderDidFinishAVAudioRecorder)(AVAudioRecorder* player,BOOL flag);
@property(nonatomic,copy)void(^blockForMP3Result)(void);
@property(nonatomic,copy)void(^blockForLuXiang)(void);
+(AudioMethod *)sharedController;
/*
 播放音频和视频；录音和录像
 */
-(void)playMusicForProductWithName:(NSString* )string WithType:(NSString*)type;//音乐路径(工程文件)
-(void)playMusicForDocumentWithPath:(NSString* )path;//音乐播放（从指定路径播放）
-(void)stopMusic;//停止播放
-(void)closepPlayMusic;//暂停播放
-(void)playBigin;//开始播放


-(void)recorderWithStringPath:(NSString*)path;//录音
-(void)recorderStop;//停止录音
-(void)recorderPause;//暂停录音


-(void)playSoundPath:(NSString* )thesoundFilePath;//播放系统提示音
+(void)playSoundID:(int)soundID;//播放系统提示音



-(UIImagePickerController* )imageForVideo;//录像
-(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;//获取视频图片


@end
