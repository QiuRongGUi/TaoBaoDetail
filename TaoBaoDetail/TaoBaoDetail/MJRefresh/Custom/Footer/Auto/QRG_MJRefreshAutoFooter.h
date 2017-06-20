//
//  QRG_MJRefreshAutoFooter.h
//  Qiu--Demo4
//
//  Created by QIUGUI on 16/6/21.
//  Copyright © 2016年 asskl. All rights reserved.
//

#import "MJRefreshAutoFooter.h"

@interface QRG_MJRefreshAutoFooter : MJRefreshAutoFooter
/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 隐藏刷新状态的文字 */
@property (assign, nonatomic, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;
@end
