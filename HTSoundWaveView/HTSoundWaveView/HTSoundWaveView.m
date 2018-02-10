//
//  HTSoundWaveView.m
//  HTSoundWaveView
//
//  Created by 海涛 黎 on 2018/2/4.
//  Copyright © 2018年 DongDong's Parents. All rights reserved.
//
#import "HTSoundWaveView.h"

@interface HTSoundWaveView()
@property(nonatomic, strong) NSMutableArray *pointYArr;  //声波峰值峰谷点位
@property(nonatomic, strong) NSMutableArray *soundPointsArr;  //声音构成点
@property(nonatomic, strong) NSMutableArray *symmetricalSoundPointsArr;  //对称的声音构成点

@property(nonatomic, strong) CAShapeLayer *soundWaveLayer;
@end

@implementation HTSoundWaveView{
    CGFloat     _xAxisSpacing;
}

-(void)setYAxisSpacing:(CGFloat)yAxisSpacing{
    _yAxisSpacing = yAxisSpacing;
    [self.soundWaveLayer removeFromSuperlayer];
    self.soundWaveLayer = nil;
    [self.soundPointsArr removeAllObjects];
    [self.symmetricalSoundPointsArr removeAllObjects];
    [self setNeedsDisplay];
}

-(void)setShowedSoundCount:(NSInteger)showedSoundCount{
    _showedSoundCount = showedSoundCount;
    _xAxisSpacing = CGRectGetWidth(self.frame) /self.showedSoundCount;
    
    [self.soundWaveLayer removeFromSuperlayer];
    self.soundWaveLayer = nil;
    [self.soundPointsArr removeAllObjects];
    [self.symmetricalSoundPointsArr removeAllObjects];
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.pointYArr = @[@(0),@(2),@(1),@(1),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(7),@(2),@(2.5),@(3),@(2),@(1),@(5),@(1),@(2),@(5),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(1),@(1),@(1),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(7),@(2),@(2.5),@(3),@(2),@(1),@(5),@(1),@(2),@(5),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(1),@(1),@(1),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(7),@(2),@(2.5),@(3),@(2),@(1),@(5),@(1),@(2),@(5),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(1),@(1),@(1),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(7),@(2),@(2.5),@(3),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(7),@(2),@(2.5),@(3),@(2),@(1),@(5),@(1),@(2),@(5),@(2),@(2),@(5),@(7),@(3),@(5),@(4),@(5),@(5),@(3),@(1),@(1),@(1),@(2),@(2),@(5),@(7),@(3),@(5),@(0)].mutableCopy;
        [self.pointYArr addObject:@(0)];
        for (NSInteger i = 0; i < 200; i++) {
            NSInteger y = 1+(arc4random() % 5);
            [self.pointYArr addObject:[NSNumber numberWithInteger:y]];
        }
        [self.pointYArr addObject:@(0)];
        
        self.showedSoundCount = 80;
        _xAxisSpacing = CGRectGetWidth(self.frame) /self.showedSoundCount;
        self.yAxisSpacing = 1;
        self.contentSize = CGSizeMake(_xAxisSpacing*self.pointYArr.count, self.frame.size.height);
        
    }
    return self;
}

-(void)startPlaySound{
    [NSTimer scheduledTimerWithTimeInterval:0.016 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.pointYArr.count <= 8) {
            [timer invalidate];
        }
        [self.soundWaveLayer removeFromSuperlayer];
        self.soundWaveLayer = nil;
        [self.pointYArr removeObjectAtIndex:4];
        [self.soundPointsArr removeAllObjects];
        [self.symmetricalSoundPointsArr removeAllObjects];
        [self setNeedsDisplay];
    }];
}

- (void)drawRect:(CGRect)rect{
    [self drawBezierPath];
}


- (void)drawBezierPath{
    [self.pointYArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger objInter = 0;
        if ([obj respondsToSelector:@selector(integerValue)]) {
            objInter = [obj integerValue];
        }
        CGPoint point = CGPointMake(_xAxisSpacing * idx, CGRectGetHeight(self.frame)/2. - objInter * self.yAxisSpacing);
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(point.x+2, point.y)];
        [self.soundPointsArr addObject:value];
        
        CGPoint symmetricalPoint = CGPointMake(_xAxisSpacing * idx, CGRectGetHeight(self.frame)/2. + objInter*self.yAxisSpacing);
        NSValue *symmetricalValue = [NSValue valueWithCGPoint:CGPointMake(symmetricalPoint.x+2, symmetricalPoint.y)];
        [self.symmetricalSoundPointsArr addObject:symmetricalValue];
    }];
    
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(0, CGRectGetHeight(self.frame) / 2)];
    [self.soundPointsArr insertObject:firstPointValue atIndex:0];
    [self.symmetricalSoundPointsArr insertObject:firstPointValue atIndex:0];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame), (CGRectGetHeight(self.frame)) / 2)];
    [self.soundPointsArr addObject:endPointValue];
    [self.symmetricalSoundPointsArr addObject:endPointValue];
    
    
    /** 折线路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound; // 线条拐角
    path.lineJoinStyle = kCGLineCapRound;// 终点处理
    
    for (NSInteger i = 0; i < self.pointYArr.count-1; i++) {
        CGPoint p1 = [[self.soundPointsArr objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[self.soundPointsArr objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[self.soundPointsArr objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[self.soundPointsArr objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
            [path addCurveToPoint:CGPointMake(p3.x, p3.y) controlPoint1:CGPointMake(p2.x, p2.y-self.yAxisSpacing*2) controlPoint2:CGPointMake(p3.x-_xAxisSpacing/3., p2.y-self.yAxisSpacing*2)];
        } else {
            [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
       }
    }
    
    for (NSInteger i = 0; i < self.pointYArr.count-1; i++) {   //绘制对称曲线
        CGPoint p1 = [[self.symmetricalSoundPointsArr objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[self.symmetricalSoundPointsArr objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[self.symmetricalSoundPointsArr objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[self.symmetricalSoundPointsArr objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
            [path addCurveToPoint:CGPointMake(p3.x, p3.y) controlPoint1:CGPointMake(p2.x, p2.y+self.yAxisSpacing*2) controlPoint2:CGPointMake(p3.x-_xAxisSpacing/3., p2.y+self.yAxisSpacing*2)];
        } else {
            [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
        }
    }
    
    
    /** 将折线添加到折线图层上，并设置相关的属性 */
    self.soundWaveLayer.path = path.CGPath;
    [self.layer addSublayer:self.soundWaveLayer];
}

- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path{
    CGFloat smooth_value = 0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}

-(void)setSmooth_value:(CGFloat)smooth_value{
    
}


#pragma mark - Getters
-(NSMutableArray *)soundPointsArr{
    if (!_soundPointsArr) {
        _soundPointsArr = [NSMutableArray array];
    }
    return _soundPointsArr;
}

-(NSMutableArray *)symmetricalSoundPointsArr{
    if (!_symmetricalSoundPointsArr) {
        _symmetricalSoundPointsArr = [NSMutableArray array];
    }
    return _symmetricalSoundPointsArr;
}


-(NSMutableArray *)pointYArr{
    if (!_pointYArr) {
        _pointYArr = [NSMutableArray array];
    }
    return _pointYArr;
}

-(CAShapeLayer *)soundWaveLayer{
    if (!_soundWaveLayer) {
        _soundWaveLayer = [CAShapeLayer layer];
        _soundWaveLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2.);
//        _soundWaveLayer.path = path.CGPath;
        _soundWaveLayer.strokeColor = [UIColor blueColor].CGColor;
        _soundWaveLayer.fillColor = [[UIColor blueColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
        _soundWaveLayer.lineWidth = 0;
        _soundWaveLayer.lineCap = kCALineCapRound;
        _soundWaveLayer.lineJoin = kCALineJoinRound;
        //    _bezierLineLayer.masksToBounds = YES;
//        [self.layer addSublayer:_bezierLineLayer];
    }
    return _soundWaveLayer;
}
@end
