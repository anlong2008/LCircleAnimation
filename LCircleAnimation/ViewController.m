//
//  ViewController.m
//  LCircleAnimation
//
//  Created by liuleilei on 15/10/16.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CAShapeLayer* redlayer;
    CAShapeLayer* whitelayer;
    CATextLayer* textLayer;
}

@property (weak, nonatomic) IBOutlet UITextField *scoreLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor orangeColor]];
    [self initLayer];
    
    [self displaySocoreWithAnimation:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLayer {
    
    redlayer             = [CAShapeLayer layer];
    redlayer.fillColor   = [[UIColor clearColor] CGColor];
    redlayer.strokeColor = [[UIColor redColor] CGColor];
    [redlayer setLineCap:kCALineCapRound];
    redlayer.lineWidth   = 7.5;
    redlayer.frame       = CGRectMake(87, 40, 144, 144);
    redlayer.borderWidth = 0;
    
    whitelayer = [CAShapeLayer layer];
    //layer.path = path;
    whitelayer.fillColor = [[UIColor clearColor] CGColor];
    whitelayer.strokeColor = [[UIColor whiteColor] CGColor];
    [whitelayer setLineCap:kCALineCapRound];
    whitelayer.lineWidth = 7.5;
    whitelayer.frame = CGRectMake(87, 40, 144, 144);
    whitelayer.borderWidth = 0;
    
    [self.view.layer addSublayer:whitelayer];
    [self.view.layer addSublayer:redlayer];
    
    textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(120, 96, 90, 40);
    textLayer.foregroundColor = [[UIColor whiteColor] CGColor];
    textLayer.font = (__bridge CFTypeRef)@"HiraKakuProN-W3";
    
    textLayer.fontSize        = 42;
    textLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setBorderWidth:0];

    [self.view.layer addSublayer:textLayer];
    
    // 绘制白色圆圈
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 76.5, 75.5, 60, -90*M_PI/180, 1*(100*3.6)*M_PI/180-90*M_PI/180, NO);
    CGContextSetRGBStrokeColor(context, 0.209, 0.304, 1.000, 1);
    whitelayer.path = path;
    
    CGPathRelease(path);
}

-(void)displaySocoreWithAnimation:(int)scrore {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, 76.5, 75.5, 60, -90*M_PI/180, 1*(scrore*3.6)*M_PI/180-90*M_PI/180, NO);
    CGContextSetRGBStrokeColor(context, 0.209, 0.304, 1.000, 1);
    
    redlayer.path = path;
    textLayer.string = @"0";
    
    CABasicAnimation *caba = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    caba.fromValue         = [NSNumber numberWithFloat:0];
    caba.toValue           = [NSNumber numberWithFloat:1];
    caba.duration          = 5.0f;
    
    [caba setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [redlayer addAnimation:caba forKey:@"key"];
    
    CAKeyframeAnimation *caba2 = [CAKeyframeAnimation animationWithKeyPath:@"string"];
    
    NSMutableArray *values = [NSMutableArray array];
    for (int i = 0; i <= scrore; i ++) {
        
        [values addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    caba2.values = values;
    caba2.duration = 5.0f;
    [caba2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut ]];
    textLayer.string= [NSString stringWithFormat:@"%d", scrore];
    [textLayer addAnimation:caba2 forKey:@"string"];
    
    CGPathRelease(path);
}

- (IBAction)startAnimation:(id)sender {
    
    if ([self.scoreLabel.text integerValue] != 0) {
        [self displaySocoreWithAnimation:self.scoreLabel.text.integerValue];
    }else{
        [self displaySocoreWithAnimation:100];
    }
}
@end
