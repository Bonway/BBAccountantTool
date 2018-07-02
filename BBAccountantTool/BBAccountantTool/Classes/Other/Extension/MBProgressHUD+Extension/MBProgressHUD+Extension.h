//
//  MBProgressHUD+Extension.h
//  BBAccountantTool
//
//  Created by Bonway on 2018/6/28.
//  Copyright © 2018年 Bonway. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)

/**
 *  小牛转圈圈
 *
 */
+ (MBProgressHUD *)showHUDProgress:(UIView *)containerView;

+ (MBProgressHUD *)showTitle:(NSString *)title toView:(UIView *)view;
@end
