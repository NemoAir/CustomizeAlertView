//
//  ViewController.m
//  NemoAlertViewDemo
//
//  Created by Nemo on 15/11/15.
//  Copyright © 2015年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "NemoFilterUserView.h"
@interface ViewController ()
@property (nonatomic, strong) NemoFilterUserView *filterView;

@property (nonatomic, strong) IBOutlet UILabel *sexLable;
@property (nonatomic, strong) IBOutlet UIImageView *sexIcon;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filter)];
    self.navigationItem.rightBarButtonItem = right;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filter)];
    [self.sexIcon addGestureRecognizer:tap];
    self.sexIcon.userInteractionEnabled = YES;
}
- (void)filter{
    
    [self.filterView show:YES completion:^(BOOL finished) {
        
    }];

}
#pragma mark - getter
-(NemoFilterUserView *)filterView{
    if (!_filterView) {
        __weak  typeof(self) weakSelf = self;

        _filterView = [NemoFilterUserView creatAlertView];
        
        self.filterView.filterBlock = ^(UserFliterType filterType){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            switch (filterType) {
                case filterNone: {
                    strongSelf.sexLable.text = @"还未选择";
                    strongSelf.sexIcon.image = [UIImage imageNamed:@"sex_default_unselected"];
                    break;
                }
                case filterMale: {
                    strongSelf.sexLable.text = @"只看男性";
                    strongSelf.sexIcon.image = [UIImage imageNamed:@"men"];
                    break;
                }
                case filterFemal: {
                    strongSelf.sexLable.text = @"只看女性";
                    strongSelf.sexIcon.image = [UIImage imageNamed:@"women"];
                    break;
                }
                case filterAll: {
                    strongSelf.sexLable.text = @"不限性别";
                    strongSelf.sexIcon.image = [UIImage imageNamed:@"sex_default_selected"];

                    break;
                }
                default: {
                    strongSelf.sexLable.text = @"还未选择";
                    strongSelf.sexIcon.image = [UIImage imageNamed:@"sex_default_unselected"];

                    break;
                }
            }
        };

    }
    return _filterView;
}
@end
