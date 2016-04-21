//
//  PlayerBrightnessView.m
//  iQiyiPlayerDemo
//
//  Created by 蓝泰致铭 on 16/4/20.
//  Copyright © 2016年 iWilsonStream. All rights reserved.
//

#import "PlayerBrightnessView.h"

@interface PlayerBrightnessView ()

//亮度背景view
@property (nonatomic, strong) UIImageView * backImage;
//亮度标题
@property (nonatomic, strong) UILabel * title;

@property (nonatomic, strong) UIView * longView;
@property (nonatomic, strong) NSMutableArray * tipArr;
@property (nonatomic, assign) BOOL orientationDidChange;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation PlayerBrightnessView

+ (instancetype) shareBrightnessView {
    static PlayerBrightnessView * brightness = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        brightness = [PlayerBrightnessView new];
        [[UIApplication sharedApplication].keyWindow addSubview:brightness];
    });
    return brightness;
}

- (instancetype)init {
    if(self = [super init]) {
        self.frame = CGRectMake(kScreenSize.width * 0.5, kScreenSize.height * 0.5, 155, 155);
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        // 使用UIToolbar实现毛玻璃效果
        UIToolbar * toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        toolbar.alpha = 0.97;
        [self addSubview:toolbar];
        
        self.backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 79, 76)];
            imageView.image = [UIImage imageNamed:@"playgesture_BrightnessSun6"];
            [self addSubview:imageView];
            imageView;
        });
        
        self.title = ({
            UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 30)];
            title.font = [UIFont boldSystemFontOfSize:16];
            title.textColor = RGBWithAlpha(0.25f, 0.22f, 0.21f, 1.f);
            title.textAlignment = NSTextAlignmentCenter;
            title.text = @"亮度";
            title;
        });
        
        self.longView = ({
            UIView * longView = [[UIView alloc] initWithFrame:CGRectMake(13, 132, self.bounds.size.width - 26, 7)];
            longView.backgroundColor = RGBWithAlpha(0.25f, 0.22f, 0.21f, 1.f);
            [self addSubview:longView];
            longView;
        });
        
        [self createTips];
        [self addNotifications];
        [self addObserver];
        
        self.alpha = 0.0;
    }
    return self;
}

- (void) createTips {
    self.tipArr = [NSMutableArray arrayWithCapacity:16];
    
    CGFloat tipW = (self.longView.bounds.size.width - 17) / 16;
    CGFloat tipH = 5;
    CGFloat tipY = 1;
    
    for(int i = 0; i < 16; i++) {
        CGFloat tipX = i * (tipW + 1) + 1;
        UIImageView * image = [[UIImageView alloc] init];
        image.backgroundColor = RGB(255, 255, 255);
        image.frame = CGRectMake(tipX, tipY, tipW, tipH);
        [self.longView addSubview:image];
        [self.tipArr addObject:image];
    }
    [self updateLongView:[UIScreen mainScreen].brightness];
}

#pragma mark - 通知
- (void) addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLayer:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void) addObserver {
    [[UIScreen mainScreen] addObserver:self forKeyPath:@"brightness" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGFloat soundValue = [change[@"new"] floatValue];
    [self appearSoundView];
    [self updateLongView:soundValue];
}

#pragma mark - Update View
- (void) updateLongView:(CGFloat)sound {
    CGFloat stage = 1 / 15.0f;
    NSInteger level = sound / stage;
    
    for(int i = 0; i < self.tipArr.count; i++) {
        UIImageView * img = self.tipArr[i];
        if(i <= level) {
            img.hidden = NO;
        } else {
            img.hidden = YES;
        }
    }
}

- (void) updateLayer:(NSNotification *)notify {
    self.orientationDidChange = YES;
    [self setNeedsLayout];
}

- (void)didMoveToSuperview {}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.orientationDidChange) {
        [UIView animateWithDuration:0.25 animations:^{
            if([UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp ||
               [UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
                self.center = CGPointMake(kScreenSize.width * 0.5, (kScreenSize.height - 10) * 0.5)
                ;
            } else {
                self.center = CGPointMake(kScreenSize.width * 0.5, kScreenSize.height * 0.5);
            }
        } completion:^(BOOL finished) {
            self.orientationDidChange = NO;
        }];
    } else {
        if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
            self.center = CGPointMake(kScreenSize.width * 0.5, (kScreenSize.height - 10) * 0.5);
        } else {
            self.center = CGPointMake(kScreenSize.width * 0.5, kScreenSize.height * 0.5);
        }
    }
    
    self.backImage.center = CGPointMake(155 * 0.5, 155 * 0.5);
}

#pragma mark - Method
- (void) appearSoundView {
    if(self.alpha == 0.0) {
        self.alpha = 1.0;
        [self updateTimer];
    }
}

- (void) disappearSoundView {
    if(self.alpha == 1.0) {
        [UIView animateWithDuration:0.8 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - Set Timer
- (void)addTimer {
    if(self.timer) return;
    
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(disappearSoundView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)removeTimer {
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)updateTimer {
    [self removeTimer];
    [self addTimer];
}

- (void) dealloc {
    [[UIScreen mainScreen] removeObserver:self forKeyPath:@"brightness"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
