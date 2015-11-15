//
//  UIView+Category.h
//  TestPro
//
//  Created by mac Nemo on 14-3-5.
//  Copyright (c) 2014年 mac Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NemoCategory)
/**
 *  set frame.origin.x = viewLeft;
 */
@property (nonatomic) CGFloat viewLeft;
/**
 *  set frame.origin.y = viewTop;
 */
@property (nonatomic) CGFloat viewTop;
/**
 *  set frame.origin.x = viewRight - frame.size.wigth;
 */
@property (nonatomic) CGFloat viewRight;
/**
 *  set frame.origin.y = viewBottom - frmae.size.height;
 */
@property (nonatomic) CGFloat viewBottom;
/**
 *  set frame.size.width = viewWidth;
 */
@property (nonatomic) CGFloat viewWidth;
/**
 *  set frame.size.height = viewHeight;
 */
@property (nonatomic) CGFloat viewHeight;
/**
 *  设置水平位置中心的值，centerY不变.
 */
@property (nonatomic) CGFloat viewCenterX;
/**
 *  设置竖直位置中心的值，centerX不变.
 */
@property (nonatomic) CGFloat viewCenterY;
/**
 *  set self.frame.origin = viewOrigin;
 */
@property (nonatomic) CGPoint viewOrigin;
/**
 *  set self.frame.bounds.size = viewSize;
 */
@property (nonatomic) CGSize viewSize;

/**
 *  使view在superview中水平、竖直居中
 */
- (void)moveToCenter;
/**
 *  使view在superview中水平居中
 */
- (void)moveToCenterX;
/**
 *  使view在superview中竖直居中
 */
- (void)moveToCenterY;

/**
 *  将view的宽度设置为superview的宽度，如果存在superview
 */
- (void)fillWidth;
/**
 *  将view的高度设置为superview的高度，如果存在superview
 */
- (void)fillHeight;
/**
 *  将view的宽高设置为superview的高宽，如果存在superview
 */
- (void)fill;
/**
 *  返回view所在层次结构中最顶层的view
 *
 */
- (UIView *)topSuperView;

/**
 *  返回view所属的viewcontroller，没有返回nil
 */

-(UIViewController *)viewcontroller;
/**
 *  移除所有subview
 */
-(void)removeAllSubviews;
/**
 *  使用图片设置view的背景，实际上是设置view的layer的content内容
 *
 *  @param img 需要设置的图片
 */
-(void)setbackgroundImage:(UIImage *)img;
/**
 *  将view带到supview在上的层级带到最前面
 */
- (void)bringToFront;


@end
