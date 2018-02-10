//
//  ViewController.m
//  HTSoundWaveView
//
//  Created by 海涛 黎 on 2018/2/3.
//  Copyright © 2018年 DongDong's Parents. All rights reserved.
//

#import "ViewController.h"
#import "HTSoundWaveView.h"
@interface ViewController ()
@property (strong, nonatomic) HTSoundWaveView *waveBackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *ssView = [[UIView alloc] initWithFrame:CGRectMake(15, 80, CGRectGetWidth(self.view.frame)-30, 60)];
    [self.view addSubview:ssView];
    ssView.layer.masksToBounds = YES;
    ssView.layer.cornerRadius = 6.;
    ssView.layer.borderWidth = 0.5;
    ssView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.waveBackView = [[HTSoundWaveView alloc] initWithFrame:ssView.bounds];
    self.waveBackView.backgroundColor = [UIColor whiteColor];
    //    self.chartView.layer.masksToBounds = YES;
    //    chartView.center = self.view.center;
    [ssView addSubview:self.waveBackView];
}
- (IBAction)heightChanged:(id)sender {
    UISlider *slider = (UISlider*)sender;
    self.waveBackView.yAxisSpacing = slider.value;
}
- (IBAction)widthChanged:(id)sender {
    UISlider *slider = (UISlider*)sender;
    self.waveBackView.showedSoundCount = slider.value;
}

- (IBAction)play:(id)sender {
    [self.waveBackView startPlaySound];
}

@end
