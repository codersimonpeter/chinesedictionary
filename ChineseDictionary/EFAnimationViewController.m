//
//  EFAnimationViewController.m
//  aaatest
//
//  Created by Jueying on 15/5/17.
//  Copyright (c) 2015年 Jueying. All rights reserved.
//

#import "EFAnimationViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "UIViewController+Common.h"
#import "CollectionTableViewController.h"

#define RADIUS 100.0
#define PHOTONUM 4
#define TAGSTART 1000
#define TIME 0.5
#define SCALENUMBER 1.25
NSInteger array [PHOTONUM][PHOTONUM] = {
//    {0,1,2,3,4},
//    {4,0,1,2,3},
//    {3,4,0,1,2},
//    {2,3,4,0,1},
//    {1,2,3,4,0}
    {0,1,2,3},
    {3,0,1,2},
    {2,3,0,1},
    {1,2,3,0},

};

@interface EFAnimationViewController ()<EFItemViewDelegate>

@property (nonatomic, assign) NSInteger currentTag;

@end

@implementation EFAnimationViewController

CATransform3D rotationTransform1[PHOTONUM];

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configViews];
}

#pragma mark - configViews 

- (void)configViews {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
    NSArray *dataArray = @[@"collection", @"clearcache", @"aboutus", @"feedback"];
    
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    
    for (NSInteger i = 0;i < PHOTONUM;i++) {
        CGFloat tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        EFItemView *view = [[EFItemView alloc] initWithNormalImage:dataArray[i] highlightedImage:[dataArray[i] stringByAppendingFormat:@"%@", @"_hover"] tag:TAGSTART+i title:nil];
        view.frame = CGRectMake(0.0, 0.0,115,115);
        view.center = CGPointMake(tmpx,tmpy);
        view.delegate = self;
        rotationTransform1[i] = CATransform3DIdentity;
        
        CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        view.layer.transform=rotationTransform;
        [self.view addSubview:view];
        
    }
    self.currentTag = TAGSTART;
}

#pragma mark - EFItemViewDelegate

- (void)didTapped:(NSInteger)index {
    
    if (self.currentTag  == index) {
//        NSLog(@"自定义处理事件 index = %ld",index);
        /*1001清理缓存
          1000我的收藏
          1003反馈意见
          1002关于我们
         */
        switch (index) {
            case 1000:
            {
                NSLog(@"我的收藏");
                CollectionTableViewController *vc = [CollectionTableViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1001:
            {
                NSLog(@"清理缓存");
               __block NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSArray *clearArray = [NSArray array];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您确定要清除缓存吗？将包括搜索历史和您的收藏" preferredStyle:(UIAlertControllerStyleActionSheet)];
                UIAlertAction *clearHistory = [UIAlertAction actionWithTitle:@"仅搜索历史" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [userDefaults setObject:clearArray forKey:@"history"];
                    [userDefaults synchronize];
                    [self tips:@"清理成功" animation:YES];
                }];
                UIAlertAction *clearCollection = [UIAlertAction actionWithTitle:@"仅我的收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [userDefaults setObject:clearArray forKey:@"collection"];
                    [userDefaults synchronize];
                    [self tips:@"清理成功" animation:YES];
                }];
                UIAlertAction *clearAll = [UIAlertAction actionWithTitle:@"全部清除" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                    [userDefaults setObject:clearArray forKey:@"collection"];
                    [userDefaults setObject:clearArray forKey:@"history"];
                    [userDefaults synchronize];
                    [self tips:@"清理成功" animation:YES];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
                [alert addAction:clearHistory];
                [alert addAction:clearCollection];
                [alert addAction:clearAll];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
                break;
            case 1002:
            {
                NSLog(@"关于我们");
                AboutViewController *vc = [AboutViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1003:
            {
                NSLog(@"反馈意见");
                FeedbackViewController *vc = [FeedbackViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
        return;
    }
    
    NSInteger t = [self getIemViewTag:index];
    
    for (NSInteger i = 0;i<PHOTONUM;i++ ) {
        
        UIView *view = [self.view viewWithTag:TAGSTART+i];
        [view.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
        [view.layer addAnimation:[self setscale:TAGSTART+i clicktag:index] forKey:@"transform"];
        
        NSInteger j = array[index - TAGSTART][i];
        CGFloat Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
    }
    self.currentTag  = index;
}

- (CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag {
    
    NSInteger i = array[clicktag - TAGSTART][tag - TAGSTART];
    NSInteger i1 = array[self.currentTag  - TAGSTART][tag - TAGSTART];
    CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    CGFloat Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber < 0.3) {
        Scalenumber = 0.4;
    }
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = TIME;
    animation.repeatCount =1;
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num {
    // CALayer
    UIView *view = [self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,view.layer.position.x,view.layer.position.y);
    
    NSInteger p =  [self getIemViewTag:tag];
    CGFloat f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    CGFloat h = f + 2.0*M_PI *num/PHOTONUM;
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    CGFloat tmpy =  centery + RADIUS*cos(h);
    CGFloat tmpx =	centerx - RADIUS*sin(h);
    view.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced"; 	
    return animation;
}

- (NSInteger)getIemViewTag:(NSInteger)tag {
    
    if (self.currentTag >tag){
        return self.currentTag  - tag;
    } else {
        return PHOTONUM  - tag + self.currentTag ;
    }
}

@end




@interface EFItemView ()

@property (nonatomic, strong) NSString *normal;
@property (nonatomic, strong) NSString *highlighted_;
@property (nonatomic, assign) NSInteger tag_;
@property (nonatomic, strong) NSString *title;

@end

@implementation EFItemView

- (instancetype)initWithNormalImage:(NSString *)normal highlightedImage:(NSString *)highlighted tag:(NSInteger)tag title:(NSString *)title {
    
    self = [super init];
    if (self) {
        _normal = normal;
        _highlighted_ = highlighted;
        _tag_ = tag;
        _title = title;
        [self configViews];
    }
    return self;
}

#pragma mark - configViews

- (void)configViews {
    
    self.tag = _tag_;
    [self setBackgroundImage:[UIImage imageNamed:_normal] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:_highlighted_] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self setTitle:_title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
}

- (void)btnTapped:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapped:)]) {
        [self.delegate didTapped:sender.tag];
    }
}

@end

