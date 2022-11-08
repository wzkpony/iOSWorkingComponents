//
//  SpeechString.m
//  PodProduct
//
//  Created by wzk on 2018/10/23.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "SpeechString.h"

@interface SpeechString()
{
    
}
@property (nonatomic, assign) NSInteger duration;//时间间隔
@property (nonatomic, copy) NSString *language;//语言格式
@property (nonatomic, assign)CGFloat rate;//语速
@property (nonatomic, strong) AVSpeechSynthesizer * synthsizer;//读文字

@property (nonatomic, assign) NSInteger duration_time;//提示语时间
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SpeechString
static  SpeechString*speech = nil;

+(SpeechString *)sharedSpeech{
    @synchronized(self){
        if(speech == nil){
            speech = [[self alloc] init];
            speech.synthsizer = [[AVSpeechSynthesizer alloc] init];
        }
    }
    return speech;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (speech == nil) {
            speech = [super allocWithZone:zone];
            return  speech;
        }
    }
    return nil;
}

- (void)stopTimer
{
    if ([_timer isValid]) {
        
        [_timer invalidate];
        
    }
    self.duration_time = 0;
    [_synthsizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    _timer = nil;
}

- (void)speechSynthesizerString:(nullable NSString *)string
                      langeuage:(nullable NSString *)language
                           rate:(CGFloat )rate
                       duration:(NSInteger )duration {
    self.duration = duration?duration:(5*60);
    self.language = [language isEqualToString:@""]?language:@"zh-CN";
    self.rate = (rate > 0)?rate:0.5f;
    
    [self speechSynthesizerString:string langeuage:self.language rate:self.rate];
    
    if (self.timer == nil) {
        __weak typeof(self)myself = self;
        self.timer = [NSTimer timerWithTimeInterval:myself.duration target:myself selector:@selector(speechTime:) userInfo:@{@"time":@(0)} repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:myself.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)speechTime:(NSTimer *)timer
{
    self.duration_time += self.duration;
    NSInteger minute = self.duration_time/60.0;//分钟
    NSString *string = Content(minute);
    [self speechSynthesizerString:string langeuage:self.language rate:self.rate];
}

- (void)speechSynthesizerString:(nullable NSString *)string
                      langeuage:(nullable NSString *)language
                           rate:(CGFloat )rate
{
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:string];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:language];//国家语言
    
    utterance.rate = rate;//声速
    
    [self.synthsizer speakUtterance:utterance];
}


@end
