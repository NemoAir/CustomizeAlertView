//
//  AlertBaseView.m
//  TaiheXiudong
//
//  Created by Nemo on 14-7-15.
//  Copyright (c) 2014年 Jie Wang. All rights reserved.
//

#import "NemoAlertBaseView.h"

@interface NemoAlertBaseView ()

@end
@implementation NemoAlertBaseView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
        [self setFrame:frame];
        
        _backView = [[UIView alloc]initWithFrame:frame];
        _backView.alpha = 0.0;
        _backView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backView];

        UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide:)];
        [_backView addGestureRecognizer:dismiss];
    }
    return self;
}

+ (id)creatAlertView
{
    return  [[self alloc]initWithFrame:CGRectZero];
}

- (void)show:(BOOL)animation
{
    [self show:animation completion:^(BOOL finished) {
        
    }];
}
- (void)show:(BOOL)animation completion:(void (^)(BOOL finished))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect rect = self.bounds;
        rect.origin.y = CGRectGetHeight(self.bounds);
        
        self.backView.frame = rect;
        
        CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
        self.alertWindow = [[UIWindow alloc]initWithFrame:frame];
        self.alertWindow.windowLevel = UIWindowLevelAlert;
        self.alertWindow.backgroundColor = [UIColor clearColor];
        [self.alertWindow makeKeyAndVisible];
        
        [self.alertWindow addSubview:self];
        
        if (animation) {
            [UIView animateWithDuration:0.4 animations:^{
                self.backView.frame = self.bounds;
                self.backView.alpha = 0.7;
            } completion:^(BOOL finished) {
                completion(finished);
            }];
        }else{
            self.backView.frame = self.bounds;
            self.backView.alpha = 0.7;
        }
 
    });
    
}
- (void)hide:(BOOL)animation{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (animation) {
            [UIView animateWithDuration:0.4 animations:^{
                CGRect rect = self.bounds;
                rect.origin.y = CGRectGetHeight(self.bounds);
                self.backView.frame = rect;
                self.backView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
                self.alertWindow.hidden = YES;
                self.alertWindow = nil;
                
            }];
        }else{
            CGRect rect = self.bounds;
            rect.origin.y = CGRectGetHeight(self.bounds);
            self.backView.frame = rect;
            self.backView.alpha = 0.0;
            [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            self.alertWindow.hidden = YES;
            self.alertWindow = nil;
        }
    });
   

}


@end
