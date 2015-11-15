//
//  AlertBaseView.h
//  TaiheXiudong
//
//  Created by Nemo on 14-7-15.
//  Copyright (c) 2014年 Jie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  该类目的是为了模仿系统的UIAlertView的实现。
 *  比如在项目中有时会出现需要自定义一个界面来让用户做出选择，实现的方式有很多。
 *  可以在当前viewcontroller的view上增加一个view来达到，但如果是一个很重要的选择，如输入手势密码，使用UIWindow来实现会更恰当和安全。
 *  该类的实现就是基于UIWindow的原理，该类只是一个基本实现，子类在initWithFrame方法中自定义需要显示的alert内容加到self的视图层级上即可。
 *  如果对动画有定制需要，需要重载show、hide方法。
 */
@interface NemoAlertBaseView : UIView
/**
 *  作为背景view使用，设置颜色或者添加imageview设置背景
 */
@property (nonatomic, strong) UIView *backView;
/**
 *  alertView显示时所处的alertWindow，隐藏后该window将变为nil
 */
@property (nonatomic, strong) UIWindow *alertWindow;

+ (id)creatAlertView;

- (void)show:(BOOL)animation;
/**
 *  显示AlertView，子类可重载，自定义显示动画
 *
 *  @param animation  是否动画显示
 *  @param completion 动画完成后的回调block
 */
- (void)show:(BOOL)animation completion:(void (^)(BOOL finished))completion;
/**
 *  隐藏AlertView，子类可重载，在定义显示动画
 *
 *  @param animation 是否动画隐藏
 */
- (void)hide:(BOOL)animation;
@end
