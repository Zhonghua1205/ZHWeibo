//
//  UIButton+Extension.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (instancetype)initWithTitle: (NSString *)title TextFont: (CGFloat)font ImageName: (NSString *)imageName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn sizeToFit];
    return btn;
}
@end
