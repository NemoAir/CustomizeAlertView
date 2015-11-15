//
//  SDFilterUserView.h
//  ShowStart_3.0
//
//  Created by Nemo on 15/6/10.
//  Copyright (c) 2015年 Jie Wang. All rights reserved.
//

#import "NemoAlertBaseView.h"

typedef NS_ENUM(NSUInteger, UserFliterType) {
    filterNone = 0,
    filterMale = 1,
    filterFemal = 2,
    filterAll = 3,
};

typedef void(^SDFilterBlock)(UserFliterType filterType);
/**
 *  自定义选择性别的弹出AlertView，用POP动画引擎重写了show|hide动画
 */
@interface NemoFilterUserView : NemoAlertBaseView

/**
 *  选择结果block
 */
@property (nonatomic, copy) SDFilterBlock filterBlock;

@end
