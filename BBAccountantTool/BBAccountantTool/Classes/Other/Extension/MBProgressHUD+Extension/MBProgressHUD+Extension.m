//
//  MBProgressHUD+Extension.m
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/28.
//  Copyright © 2018年 Bonway. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (MBProgressHUD *)showHUDProgress:(UIView *)containerView{
    

    UIImage *image = [UIImage imageNamed:@"loading"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];

    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; //让其在z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];//旋转角度
    rotationAnimation.duration = 1; //旋转周期
    rotationAnimation.cumulative = YES;//旋转累加角度
    rotationAnimation.repeatCount = 100000;//旋转次数
    [imgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES];
//    hud.userInteractionEnabled = NO;
    hud.customView = imgView;
    hud.bezelView.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationFade;

    return hud;
}


+ (MBProgressHUD *)showTitle:(NSString *)title toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(title, @"HUD message title");
    hud.bezelView.alpha = 0.9;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.textColor = [UIColor whiteColor];
//    hud.userInteractionEnabled = NO; //userInteractionEnabled=NO时，不会遮挡containerView，view可以正常响应
    //Move to bottm center.
    hud.offset = CGPointMake(0.f, -50);
    
    [hud hideAnimated:YES afterDelay:2.f];
    return hud;
}
@end
