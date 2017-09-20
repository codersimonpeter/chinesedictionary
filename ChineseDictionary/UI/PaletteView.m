//
//  PaletteView.m
//  lianxi  - 04
//
//  Created by lx刘逍 on 16/3/1.
//  Copyright © 2016年 LiuXiao. All rights reserved.
//
// 414 * 736

#import "PaletteView.h"

typedef enum {
    black = 0,
    red,
    blue,
    pink,
    orange,
    green,
    gray,
    yellow
}colorTypes;
@interface PaletteView ()
{
    NSMutableArray *points;
    NSMutableArray *lines;
    NSMutableArray *cycleLines;
    float _size;
    colorTypes _colorType;
    
}
@property (strong, nonatomic) UIButton *colorButton;
@property (strong, nonatomic) UIButton *sizeButton;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *cycleButton;
@property (strong, nonatomic) UISlider *sizeSlider;
@property (strong, nonatomic) UIScrollView *colorView;
@end

@implementation PaletteView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        lines = [NSMutableArray array];
        cycleLines = [NSMutableArray array];
        _size = 5;
        _colorType = black;
        [self creatUI];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (_colorType) {
        case black:
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
            break;
        case blue:
            CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
            break;
        case red:
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
            break;
        case orange:
            CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
            break;
        case gray:
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            break;
        case green:
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            break;
        case yellow:
            CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
            break;
        case pink:
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:227/255.0 green:106/255.0 blue:164/255.0 alpha:1].CGColor);
            break;
        default:
            break;
    

    }
    CGContextSetLineWidth(context, _size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);

     if(points.count > 0)
    {
       if (lines.count > 0)
        {
            for (NSMutableDictionary *dic in lines) {
                NSMutableArray *poi = dic[@"points"];
                float size = [dic[@"size"] floatValue];
                CGContextSetLineWidth(context, size);
                colorTypes colorType = [dic[@"colorType"] intValue];
                switch (colorType) {
                    case black:
                        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
                        break;
                    case blue:
                        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
                        break;
                    case red:
                        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
                        break;
                    case orange:
                        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
                        break;
                    case gray:
                        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
                        break;
                    case green:
                        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
                        break;
                    case yellow:
                        CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
                        break;
                    case pink:
                        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255/255.0 green:192/255.0 blue:203/255.0 alpha:1].CGColor);
                        break;
                    default:
                        break;
                }
                CGContextMoveToPoint(context, [poi[0] CGPointValue].x, [poi[0] CGPointValue].y);
                for (id obj in poi) {
                    CGContextAddLineToPoint(context, [obj CGPointValue].x, [obj CGPointValue].y);
                }
                CGContextStrokePath(context);
            }

        }
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    points  = [NSMutableArray array];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:point]];
//    NSLog(@"%@",[NSValue valueWithCGPoint:point]);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:points forKey:@"points"];
    [dic setObject:[NSNumber numberWithFloat:_size] forKey:@"size"];
    [dic setObject:[NSNumber numberWithInt:_colorType] forKey:@"colorType"];
    [lines addObject:dic];
    self.sizeSlider.hidden = YES;
    self.colorView.hidden = YES;
    

    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:point]];
//    NSLog(@"%@",[NSValue valueWithCGPoint:point]);
//    [points insertObject:[NSValue valueWithCGPoint:point] atIndex:0];

    [self setNeedsDisplay];
//    [lines addObject:points];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [points addObject:[NSValue valueWithCGPoint:point]];
//    NSLog(@"%@",[NSValue valueWithCGPoint:point]);
    
    [self setNeedsDisplay];

}
- (void)creatUI
{

//    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.clearButton setTitle:@"清空" forState:UIControlStateNormal];
//    self.clearButton.titleLabel.font = [UIFont systemFontOfSize:26];
//    [self.clearButton setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
//    self.clearButton.frame = CGRectMake(167, 700, 80, 36);
//    [self.clearButton addTarget:self action:@selector(clear) forControlEvents:(UIControlEventTouchUpInside)];
//    [self addSubview:self.clearButton];
}
- (void)changeSize:(UISlider *)sender
{
    _size = sender.value;
}
- (void)showSizeSlider
{
    self.colorView.hidden = YES;
    self.sizeSlider.hidden = NO;
}
- (void)showColorView
{
    self.sizeSlider.hidden = YES;
    self.colorView.hidden = NO;
}

- (void)clear
{
    [lines removeAllObjects];
    [self setNeedsDisplay];

}
- (void)back
{
    if (lines.count > 0) {
        NSMutableDictionary *dic = [lines lastObject];
        [lines removeLastObject];
        [cycleLines addObject:dic];
        [self setNeedsDisplay];
    }
}
- (void)cycle
{
    if (cycleLines.count > 0) {
        NSMutableDictionary *dic = [cycleLines lastObject];
        [cycleLines removeLastObject];
        [lines addObject:dic];
        [self setNeedsDisplay];
    }
    
}
@end
