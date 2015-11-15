//
//  UIView+Category.m
//  TestPro
//
//  Created by mac Nemo on 14-3-5.
//  Copyright (c) 2014年 mac Nemo. All rights reserved.
//

#import "UIView+NemoCategory.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (NemoCategory)
-(CGFloat)viewLeft{
    return self.frame.origin.x;
}

-(void)setViewLeft:(CGFloat)viewLeft{
    CGRect frame = self.frame;
    frame.origin.x = viewLeft;
    self.frame = frame;
}

-(CGFloat)viewTop{
    return self.frame.origin.y;
}

-(void)setViewTop:(CGFloat)viewTop{
    CGRect frame = self.frame;
    frame.origin.y = viewTop;
    self.frame = frame;
}

-(CGFloat)viewRight{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setViewRight:(CGFloat)viewRight{
    CGRect frame = self.frame;
    frame.origin.x = viewRight - frame.size.width;
    self.frame = frame;
}

-(CGFloat)viewBottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setViewBottom:(CGFloat)viewBottom{
    CGRect frame = self.frame;
    frame.origin.y = viewBottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)viewCenterX{
    return self.center.x;
}

-(void)setViewCenterX:(CGFloat)viewCenterX{
    self.center = CGPointMake(viewCenterX, self.center.y);
}

-(CGFloat)viewCenterY{
    return self.center.y;
}

-(void)setViewCenterY:(CGFloat)viewCenterY{
    self.center = CGPointMake(self.center.x, viewCenterY);
}

- (void)moveToCenter;
{
    [self moveToCenterX];
    [self moveToCenterY];
}
- (void)moveToCenterX
{
    if (self.superview) {
        self.viewLeft = (self.superview.viewWidth - self.viewWidth)/2.0f;
    }
}
- (void)moveToCenterY
{
    if (self.superview) {
        self.viewTop = (self.superview.viewHeight - self.viewHeight)/2.0f;
    }
}
-(CGFloat)viewWidth{
    return self.frame.size.width;
}

-(void)setViewWidth:(CGFloat)viewWidth{
    CGRect frame = self.frame;
    frame.size.width = viewWidth;
    self.frame = frame;
}

-(CGFloat)viewHeight{
    return self.frame.size.height;
}

-(void)setViewHeight:(CGFloat)viewHeight{
    CGRect frame = self.frame;
    frame.size.height = viewHeight;
    self.frame = frame;
}

-(CGPoint)viewOrigin{
    return self.frame.origin;
}

-(void)setViewOrigin:(CGPoint)viewOrigin{
    CGRect frame = self.frame;
    frame.origin = viewOrigin;
    self.frame = frame;
}

-(CGSize)viewSize{
    return self.frame.size;
}

-(void)setViewSize:(CGSize)viewSize{
    CGRect frame = self.frame;
    frame.size = viewSize;
    self.frame = frame;
}


- (void)fillWidth
{
    if (self.superview) {
        self.viewWidth = self.superview.viewWidth;
    }
}

- (void)fillHeight
{
    if (self.superview) {
        self.viewHeight = self.superview.viewHeight;
    }
}

- (void)fill
{
    if (self.superview) {
        self.frame = CGRectMake(0, 0, self.superview.viewWidth, self.superview.viewHeight);
    }
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

-(UIViewController *)viewcontroller{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)removeAllSubviews{
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

-(void)setbackgroundImage:(UIImage *)img{
    if (img) {
        self.layer.contents = (__bridge id)[img CGImage];
    }
}

- (void)bringToFront
{
    if (self.superview) {
        [self.superview bringSubviewToFront:self];
    }
}




@end
