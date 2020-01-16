//
//  UIScreen+Animation.h
//  TopsTechLoop
//
//  Created by 刘继新 on 2017/5/22.
//  Copyright © 2017年 TopsTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Animation)

@property (nonatomic, assign) CGFloat kk_currentLight;

/// 平滑调节屏幕亮度
- (void)kk_setBrightness:(CGFloat)brightness animation:(BOOL)flag;

@end
