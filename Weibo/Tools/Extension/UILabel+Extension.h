//
//  UILabel+Extension.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
// 便利构造函数
- (instancetype)initWithTitle: (NSString *)title textFont: (CGFloat)font screenOffSet: (CGFloat)offSet;
@end
