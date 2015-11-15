//
//  SDFilterUserView.m
//  ShowStart_3.0
//
//  Created by Nemo on 15/6/10.
//  Copyright (c) 2015年 Jie Wang. All rights reserved.
//

#import "NemoFilterUserView.h"
#import "UIView+NemoCategory.h"
#import <AVFoundation/AVFoundation.h>
#import <POP.h>
#ifndef SCREEN_WIDTH

#define SCREEN_WIDTH    ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? \
[[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#endif

#ifndef SCREEN_HEIGHT

#define SCREEN_HEIGHT   ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? \
[[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#endif

@interface NemoFilterUserView ()

@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UILabel *maleLabel;

@property (nonatomic, strong) UIButton *femaleButton;
@property (nonatomic, strong) UILabel *femaleLabel;

@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) UILabel *allLabel;

@property (nonatomic, strong) UILabel *filterLabel;
@property (nonatomic, assign) UserFliterType filterType;

@property (nonatomic, strong) AVAudioPlayer *player;



@end

@implementation NemoFilterUserView{
    CGFloat buttonWidth ;
    CGFloat horizonShiftDistance ;
    CGFloat verticalShiftDistance;
    CGFloat LableVerticalDistance ;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        buttonWidth = 68;
        horizonShiftDistance = (SCREEN_WIDTH - 68 * 2)/2;
        verticalShiftDistance = horizonShiftDistance;
        LableVerticalDistance = 15;
        //自定义子类需要呈现的alertView内容
        self.backView.backgroundColor =  [UIColor colorWithRed:30/255.0f green:31/255.0f blue:37/255.0f alpha:1.0];
        
        [self addSubview:self.maleButton];
        [self addSubview:self.filterLabel];
        [self addSubview:self.maleLabel];
        [self addSubview:self.femaleButton];
        [self addSubview:self.femaleLabel];
        [self addSubview:self.allButton];
        [self addSubview:self.allLabel];
        
        self.filterType = filterNone;
        [self player];
        [self initialLayout];
    }
    return self;
}
-(void)initialLayout{
    
    [self.maleButton moveToCenter];
    self.maleButton.viewRight -= horizonShiftDistance;
    self.maleButton.viewBottom = _maleButton.viewTop;
    
    [self.filterLabel moveToCenter];
    self.filterLabel.viewBottom = _maleButton.viewTop - buttonWidth/2.0;
    
    self.maleLabel.viewCenterX = _maleButton.viewCenterX;
    self.maleLabel.viewTop = _maleButton.viewBottom + LableVerticalDistance;
    
    [self.femaleButton moveToCenter];
    self.femaleButton.viewTop = _maleButton.viewTop;
    self.femaleButton.viewLeft += horizonShiftDistance;
    
    self.femaleLabel.viewCenterX = _femaleButton.viewCenterX;
    self.femaleLabel.viewTop = self.maleLabel.viewTop;
    
    [self.allButton moveToCenter];
    self.allButton.viewTop = _femaleButton.viewBottom + LableVerticalDistance * 3;
    
    self.allLabel.viewCenterX = _allButton.viewCenterX;
    self.allLabel.viewTop = _allButton.viewBottom + LableVerticalDistance;
}

- (void)setMaleButtonChoose:(BOOL)choose{
    if (choose) {
        [self.maleButton setImage:[UIImage imageNamed:@"men"] forState:UIControlStateNormal];
        self.maleLabel.textColor = [UIColor whiteColor];
        self.maleLabel.text = @"<只看男性>";
    }else{
        [self.maleButton setImage:[UIImage imageNamed:@"men_dark"] forState:UIControlStateNormal];
        self.maleLabel.textColor =  [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
        self.maleLabel.text = @"只看男性";
    }
    self.maleLabel.viewCenterX = self.maleButton.viewCenterX;
}
- (void)setFemaleButtonChoose:(BOOL)choose{
    if (choose) {
        [self.femaleButton setImage:[UIImage imageNamed:@"women"] forState:UIControlStateNormal];
        self.femaleLabel.textColor = [UIColor whiteColor];
        self.femaleLabel.text = @"<只看女性>";
    }else {
        [self.femaleButton setImage:[UIImage imageNamed:@"women_dark"] forState:UIControlStateNormal];
        self.femaleLabel.textColor =  [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
        self.femaleLabel.text = @"只看女性";

    }
    self.femaleLabel.viewCenterX = self.femaleButton.viewCenterX;
}
- (void)setAllButtonChoose:(BOOL)choose{
    if (choose) {
        [self.allButton setImage:[UIImage imageNamed:@"sex_default_selected"] forState:UIControlStateNormal];
        self.allLabel.textColor = [UIColor whiteColor];
        self.allLabel.text = @"<不限性别>";

    }else {
        [self.allButton setImage:[UIImage imageNamed:@"sex_default_unselected"] forState:UIControlStateNormal];;
        self.allLabel.textColor =  [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
        self.allLabel.text = @"不限性别";
    }
    self.allLabel.viewCenterX = self.allButton.viewCenterX;
}
- (void)maleButtonClicked:(UIButton *)button{
    self.filterType = filterMale;
    [self setMaleButtonChoose:YES];
    [self setFemaleButtonChoose:NO];
    [self setAllButtonChoose:NO];
    [self hide:YES];
    
}
- (void)femaleButtonClicked:(UIButton *)button{
    self.filterType = filterFemal;
    [self setMaleButtonChoose:NO];
    [self setFemaleButtonChoose:YES];
    [self setAllButtonChoose:NO];
    [self hide:YES];
}
- (void)allButtonClicked:(UIButton *)button{
    self.filterType = filterAll;
    [self setMaleButtonChoose:NO];
    [self setFemaleButtonChoose:NO];
    [self setAllButtonChoose:YES];
    [self hide:YES];
}

#pragma mark - override
- (void)show:(BOOL)animation completion:(void (^)(BOOL finished))completion{
    CGRect rect = self.bounds;
    rect.origin.y = CGRectGetHeight(self.bounds);
    
    self.backView.frame = rect;
    
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.alertWindow = [[UIWindow alloc]initWithFrame:frame];
    self.alertWindow.windowLevel = UIWindowLevelAlert;
    self.alertWindow.backgroundColor = [UIColor clearColor];
    [self.alertWindow makeKeyAndVisible];

    [self.alertWindow addSubview:self];

    self.backView.frame = self.bounds;
    self.backView.alpha = 0.9;
    

    [self hideContent];
    [UIView animateWithDuration:0.4 animations:^{
        self.filterLabel.alpha = 1.0;
    }];
    [self.player play];

    [self showMale];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showFemale];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showAll];
    });
    if (completion) {
        completion(YES);
    }
}
- (void)hide:(BOOL)animation{
    __weak  typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideContent];
            
        } completion:^(BOOL finished) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.filterBlock) {
                strongSelf.filterBlock(strongSelf.filterType);
            }
            [UIView animateWithDuration:0.25 animations:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                CGRect rect = strongSelf.bounds;
                rect.origin.y = CGRectGetHeight(strongSelf.bounds);
                strongSelf.backView.frame = rect;
                strongSelf.backView.alpha = 0.0;
                [strongSelf removeFromSuperview];
                strongSelf.alertWindow.hidden = YES;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
                strongSelf.alertWindow = nil;
                
            }];
            
        }];

    });
    
}
- (void)showMale{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.maleLabel.alpha = 1.0;
        
        //    [self popShowView:self.maleLabel withAnimationName:@"maleLabel" dynamicMass:15 andCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //    }];
        [self popShowView:self.maleButton withAnimationName:@"maleButton" andCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        }];
    });

}
- (void)showFemale{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.femaleLabel.alpha = 1.0;
        //    [self popShowView:self.femaleLabel withAnimationName:@"femaleLabel" dynamicMass:5 andCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //    }];
        [self popShowView:self.femaleButton withAnimationName:@"femaleButton" andCompletionBlock:^(POPAnimation *anim, BOOL finished){
            
        }];
    });

}
- (void)showAll{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.allLabel.alpha = 1.0;
        //    [self popShowView:self.allLabel withAnimationName:@"allLabel" dynamicMass:15 andCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //    }];
        [self popShowView:self.allButton withAnimationName:@"allButton" andCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        }];
    });

}
- (void)hideContent{
    self.maleButton.alpha = 0.0;
    self.femaleButton.alpha = 0.0;
    self.allButton.alpha = 0.0;
    self.maleLabel.alpha = 0.0;
    self.allLabel.alpha = 0.0;
    self.femaleLabel.alpha = 0.0;
    self.filterLabel.alpha = 0.0;
}
#pragma mark - pop animation
- (void)popShowView:(UIView *)view withAnimationName:(NSString *)name{
    
    view.alpha = 1.0;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    CGRect toRect = view.frame;
    CGRect fromRect = CGRectInset(toRect, toRect.size.width * 0.3, toRect.size.height * 0.3);
    springAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    springAnimation.toValue = [NSValue valueWithCGRect:toRect];
    springAnimation.name = name;
    springAnimation.delegate = self;
    [view pop_addAnimation:springAnimation forKey:name];

}
- (void)popShowView:(UIView *)view withAnimationName:(NSString *)name dynamicMass:(CGFloat)mass andCompletionBlock:(void (^)(POPAnimation *anim, BOOL finished))completion{
    view.alpha = 1.0;
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    
    CGRect toRect = view.frame;
    CGRect fromRect = CGRectInset(toRect, toRect.size.width * 0.3, toRect.size.height * 0.3);
    springAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    springAnimation.toValue = [NSValue valueWithCGRect:toRect];
    springAnimation.name = name;
    springAnimation.springBounciness = 16;
    springAnimation.dynamicsMass = mass;
    springAnimation.springSpeed = 8;
//    springAnimation.dynamicsTension = mass;
//    springAnimation.dynamicsFriction = 20;
    [view pop_addAnimation:springAnimation forKey:name];
    springAnimation.completionBlock = completion;
}

- (void)popShowView:(UIView *)view withAnimationName:(NSString *)name andCompletionBlock:(void (^)(POPAnimation *anim, BOOL finished))completion{
    [self popShowView:view withAnimationName:name dynamicMass:20 andCompletionBlock:completion];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished{
    if ([anim.name isEqualToString:@"maleButton"]) {
        self.maleLabel.hidden = NO;
        [self popShowView:self.femaleButton withAnimationName:@"femaleButton"];
        [self.player play];
    }else if([anim.name isEqualToString:@"femaleButton"]){
        self.femaleLabel.hidden = NO;
        [self popShowView:self.allButton withAnimationName:@"allButton"];
        [self.player play];
        
    }else if([anim.name isEqualToString:@"allButton"]){
        [self popShowView:self.allButton withAnimationName:@"allButton"];
        self.allLabel.hidden = NO;
        [self.player play];
    }
}
- (void)popShowView:(UIView *)view completion:(void (^)(BOOL finished))completion{
    view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [self playSound];
    view.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completion(finished);
    }];

}

#pragma mark - play sound
- (void)playSound{
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"drop" ofType:@"mp3"];
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    SystemSoundID audioEffect;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
   
    // Using GCD, we can use a block to dispose of the audio effect without using a NSTimer or something else to figure out when it'll be finished playing.
    //稍后释放audioEffect,否则可能引起崩溃
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AudioServicesDisposeSystemSoundID(audioEffect);
    });

}
#pragma mark - getter
-(UIButton *)maleButton{
    if (!_maleButton) {
        _maleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
        [_maleButton setImage:[UIImage imageNamed:@"men_dark"] forState:UIControlStateNormal];
        [_maleButton addTarget:self action:@selector(maleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maleButton;
}
-(UIButton *)femaleButton{
    if (!_femaleButton) {
        _femaleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
        [_femaleButton setImage:[UIImage imageNamed:@"women_dark"] forState:UIControlStateNormal];
        [_femaleButton addTarget:self action:@selector(femaleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _femaleButton;
}
-(UIButton *)allButton{
    if (!_allButton) {
        _allButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
        [_allButton setImage:[UIImage imageNamed:@"sex_default_selected"] forState:UIControlStateNormal];
        [_allButton addTarget:self action:@selector(allButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _allButton;
}
-(UILabel *)filterLabel{
    if (!_filterLabel) {
        _filterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 17)];
        _filterLabel.font = [UIFont boldSystemFontOfSize:16];
        _filterLabel.text = @"筛选条件";
        _filterLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0];
        
        _filterLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _filterLabel;
}
-(UILabel *)maleLabel{
    if (!_maleLabel) {
        _maleLabel = [self creatLable];
        _maleLabel.text = @"只看男性";
    }
    return _maleLabel;
}
-(UILabel *)femaleLabel{
    if (!_femaleLabel) {
        _femaleLabel = [self creatLable];
        _femaleLabel.text = @"只看女性";
    }
    return _femaleLabel;
}
-(UILabel *)allLabel{
    if (!_allLabel) {
        _allLabel = [self creatLable];
        _allLabel.text = @"<不限性别>";
        _allLabel.textColor = [UIColor whiteColor];
    }
    return _allLabel;
}
- (UILabel *)creatLable{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 13)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor =  [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
-(AVAudioPlayer *)player{
    if (!_player) {
        NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"drop" withExtension:@"mp3"];
        NSError *error;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pathURL error:&error];
        audioPlayer.numberOfLoops = 0;
        
        _player = audioPlayer;
    }
    return _player;
}

@end
