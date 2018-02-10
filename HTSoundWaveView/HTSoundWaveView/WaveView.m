//
//  WaveView.m
//  HTSoundWaveView
//
//  Created by 海涛 黎 on 2018/2/4.
//  Copyright © 2018年 DongDong's Parents. All rights reserved.
//

#import "WaveView.h"
@interface WaveView()
@property(nonatomic, strong) NSMutableArray *volumeArr;
@end
@implementation WaveView
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 10, 10);
//    CGContextAddCurveToPoint(context,100,100,175,150,200,100);
//    CGContextAddCurveToPoint(context,225,50,275,75,300,200);
    CGFloat padding = 20;
    CGFloat newX = 10;
    CGFloat newY = 10;
    CGFloat oldX = 0;
    CGFloat oldY = 0;
    for (NSInteger i = 1; i < 20; i++) {
        float y =  (arc4random() % 21);
        newX = 10+i*padding;
        newY = y;
        CGContextAddCurveToPoint(context,oldX,oldY,(newX - oldX)/2. + oldX,7.5,newX,newY);
        oldX = newX;
        oldY = newY;
    }
//    CGContextAddCurveToPoint(context,22.5,2,27.5,7.5,30,20);
    CGContextStrokePath(context);
}

//-(void)drawRect:(CGRect)rect{
//    CGFloat width = 12;
//    CGFloat startX = 20;
//
//    CGFloat volumeChangeScope = 10;
//
//
//    [[UIColor orangeColor] set];
//    CGFloat oldVolumeHeight = 0;
//    CGFloat newVolumeHeight = 0;
//    for (NSInteger i = 0; i<20; i++) {
//        NSNumber *number = [self.volumeArr objectAtIndex:i];
//
//        newVolumeHeight = number.floatValue * volumeChangeScope;
//        UIBezierPath *path9 = [UIBezierPath bezierPath];
//        [path9 moveToPoint:CGPointMake(startX + width*i, 25 - oldVolumeHeight)];
//        [path9 addQuadCurveToPoint:CGPointMake(startX + width*(i+1), 25-newVolumeHeight) controlPoint:CGPointMake(startX + width*i+width/2., 10)];
//        [path9 stroke];
//
//        UIBezierPath *path10 = [UIBezierPath bezierPath];
//        [path10 moveToPoint:CGPointMake(startX + width*i, 25+oldVolumeHeight)];
//        [path10 addQuadCurveToPoint:CGPointMake(startX + width*(i+1), 25+newVolumeHeight) controlPoint:CGPointMake(startX + width*i+width/2., 25+10)];
//        [path10 stroke];
//
//        oldVolumeHeight = newVolumeHeight;
//    }
//}

-(NSMutableArray *)volumeArr{
    if (!_volumeArr) {
        _volumeArr = [NSMutableArray array];
        for (NSInteger i = 0; i<20; i++) {
            float y =  (arc4random() % 101)/100.;
            NSNumber *number = [NSNumber numberWithFloat:y];
            [_volumeArr addObject:number];
        }
    }
    return _volumeArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
