//
//  UIScreen+Animation.m
//  TopsTechLoop
//
//  Created by 刘继新 on 2017/5/22.
//  Copyright © 2017年 TopsTech. All rights reserved.
//

#import "UIScreen+Animation.h"
#import <objc/runtime.h>

@implementation UIScreen (Animation)

static CGFloat coefficient = 0.02f; // 系数，每次调节的亮度值。

- (void)kk_setBrightness:(CGFloat)brightness animation:(BOOL)flag {
    self.kk_currentLight = brightness;
    if (flag) {
        CADisplayLink *displayTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_kk_changeLight:)];
        displayTimer.frameInterval = 1;
        [displayTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    } else {
        [UIScreen mainScreen].brightness = self.kk_currentLight;
    }
}

- (void)_kk_changeLight:(CADisplayLink *)sender {
    CGFloat brightness = [UIScreen mainScreen].brightness;
    CGFloat diff = brightness - self.kk_currentLight;
    if (fabs(diff) <= coefficient) {
        [sender invalidate];
        return;
    }
    CGFloat f = fabs(self.kk_currentLight - brightness);
    if (f < coefficient) {
        coefficient = f;
    }
    if (self.kk_currentLight > brightness) {
        [UIScreen mainScreen].brightness += coefficient;
    } else {
        [UIScreen mainScreen].brightness -= coefficient;
    }
}

- (CGFloat)kk_currentLight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setKk_currentLight:(CGFloat)kk_currentLight {
    objc_setAssociatedObject(self, @selector(kk_currentLight), @(kk_currentLight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
