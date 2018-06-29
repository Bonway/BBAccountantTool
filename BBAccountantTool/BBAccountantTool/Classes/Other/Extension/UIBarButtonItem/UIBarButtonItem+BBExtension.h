//
//  UIBarButtonItem+BWItem.h
//  Bonway
//
//  Created by Bonway(黄邦伟) on 14/3/27.
//  Copyright © 2014年 Bonway(黄邦伟). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BBExtension)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents andMargin:(CGFloat)margin;

//上图片下文字
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
