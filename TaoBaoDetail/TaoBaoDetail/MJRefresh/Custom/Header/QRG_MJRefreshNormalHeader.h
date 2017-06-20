//
//  QRG_MJRefreshNormalHeader.h
//  Qiu--Demo4
//
//  Created by QIUGUI on 16/6/22.
//  Copyright © 2016年 asskl. All rights reserved.
//

#import "QRG_MJRefreshStateHeader.h"

@interface QRG_MJRefreshNormalHeader : QRG_MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@end
