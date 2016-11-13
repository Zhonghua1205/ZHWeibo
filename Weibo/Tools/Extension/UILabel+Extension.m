//
//  UILabel+Extension.m
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
/**
 便利构造函数
 
 @param title  文本内容
 @param font   文本字体大小
 @param offSet 缩进
 
 @return UIlabel
 */
- (instancetype)initWithTitle: (NSString *)title textFont: (CGFloat)font screenOffSet: (CGFloat)offSet {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 0;
    [label sizeToFit];
    if (offSet == 0) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
        label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 2 * offSet;
        label.textAlignment = NSTextAlignmentLeft;
    }
    return label;
}
@end
