//
//  SpeechString.h
//  PodProduct
//
//  Created by wzk on 2018/10/23.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>


/**
 语言类别
 IOS7包含了一组可以用来合成的声音的嗓音，你可以自定义多种嗓音来合成。
 
 "[AVSpeechSynthesisVoice 0x978a0b0] Language: th-TH",
 
 "[AVSpeechSynthesisVoice 0x977a450] Language: pt-BR",
 
 "[AVSpeechSynthesisVoice 0x977a480] Language: sk-SK",
 
 "[AVSpeechSynthesisVoice 0x978ad50] Language: fr-CA",
 
 "[AVSpeechSynthesisVoice 0x978ada0] Language: ro-RO",
 
 "[AVSpeechSynthesisVoice 0x97823f0] Language: no-NO",
 
 "[AVSpeechSynthesisVoice 0x978e7b0] Language: fi-FI",
 
 "[AVSpeechSynthesisVoice 0x978af50] Language: pl-PL",
 
 "[AVSpeechSynthesisVoice 0x978afa0] Language: de-DE",
 
 "[AVSpeechSynthesisVoice 0x978e390] Language: nl-NL",
 
 "[AVSpeechSynthesisVoice 0x978b030] Language: id-ID",
 
 "[AVSpeechSynthesisVoice 0x978b080] Language: tr-TR",
 
 "[AVSpeechSynthesisVoice 0x978b0d0] Language: it-IT",
 
 "[AVSpeechSynthesisVoice 0x978b120] Language: pt-PT",
 
 "[AVSpeechSynthesisVoice 0x978b170] Language: fr-FR",
 
 "[AVSpeechSynthesisVoice 0x978b1c0] Language: ru-RU",
 
 "[AVSpeechSynthesisVoice 0x978b210]Language: es-MX",
 
 "[AVSpeechSynthesisVoice 0x978b2d0] Language: zh-HK",
 
 "[AVSpeechSynthesisVoice 0x978b320] Language: sv-SE",
 
 "[AVSpeechSynthesisVoice 0x978b010] Language: hu-HU",
 
 "[AVSpeechSynthesisVoice 0x978b440] Language: zh-TW",
 
 "[AVSpeechSynthesisVoice 0x978b490] Language: es-ES",
 
 "[AVSpeechSynthesisVoice 0x978b4e0] Language: zh-CN",汉语
 
 "[AVSpeechSynthesisVoice 0x978b530] Language: nl-BE",
 
 "[AVSpeechSynthesisVoice 0x978b580] Language: en-GB",
 
 "[AVSpeechSynthesisVoice 0x978b5d0] Language: ar-SA",
 
 "[AVSpeechSynthesisVoice 0x978b620] Language: ko-KR",
 
 "[AVSpeechSynthesisVoice 0x978b670] Language: cs-CZ",
 
 "[AVSpeechSynthesisVoice 0x978b6c0] Language: en-ZA",
 
 "[AVSpeechSynthesisVoice 0x978aed0] Language: en-AU",
 
 "[AVSpeechSynthesisVoice 0x978af20] Language: da-DK",
 
 "[AVSpeechSynthesisVoice 0x978b810] Language: en-US",
 
 "[AVSpeechSynthesisVoice 0x978b860] Language: en-IE",
 
 "[AVSpeechSynthesisVoice 0x978b8b0] Language: hi-IN",
 
 "[AVSpeechSynthesisVoice 0x978b900] Language: el-GR",
 
 "[AVSpeechSynthesisVoice 0x978b950] Language: ja-JP"
 */
NS_ASSUME_NONNULL_BEGIN

//提示语
#define Content(minute) ([NSString stringWithFormat:@"您已经运动%ld分钟了",(long)minute]);


@interface SpeechString : NSObject

+(SpeechString *)sharedSpeech;

- (void)stopTimer;//停止播放
/*
 描述：语音读文字。
 参数：{
 string -> 文字
 language -> 语言格式
 rate -> 语速（0,1）默认是0.5
 duration -> 时间间隔
 }
 
 */
- (void)speechSynthesizerString:(nullable NSString *)string
                      langeuage:(nullable NSString *)language
                           rate:(CGFloat )rate
                       duration:(NSInteger )duration;//读文字

@end

NS_ASSUME_NONNULL_END
