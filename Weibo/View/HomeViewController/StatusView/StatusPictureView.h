//
//  StatusPictureView.h
//  Weibo
//
//  Created by 卢中华 on 2016/11/10.
//  Copyright © 2016年 卢中华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewModel.h"

@interface StatusPictureView : UICollectionView
// 微博视图模型
@property (nonatomic, strong) StatusViewModel *viewModel;
@end

