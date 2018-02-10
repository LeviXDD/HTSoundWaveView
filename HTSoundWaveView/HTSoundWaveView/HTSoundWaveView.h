//
//  HTSoundWaveView.h
//  HTSoundWaveView
//
//  Created by 海涛 黎 on 2018/2/4.
//  Copyright © 2018年 DongDong's Parents. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface HTSoundWaveView : UIScrollView
@property(nonatomic, assign)  CGFloat smooth_value;
@property(nonatomic, assign) NSInteger showedSoundCount;
@property(nonatomic, assign) CGFloat yAxisSpacing;
-(void)startPlaySound;
@end
