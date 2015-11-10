//
//  MyLable.m
//  标签滚动
//
//  Created by 王明申 on 15/11/10.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//

#import "MyLable.h"
#define CZNormalFontSize 14.0
#define CZSelectedFontSize 18.0

@implementation MyLable

-(void)setScale:(float)scale {

        float percent = (CZSelectedFontSize - CZNormalFontSize) / CZNormalFontSize;
        percent = percent*scale +1;
        self.transform = CGAffineTransformMakeScale(percent, percent);
        self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    

}
//设置标签
+(MyLable*)setUpLable:(NSString *)title {
    MyLable *lable = [[MyLable alloc]init];
    lable.text = title;
    //    lable.textColor = [UIColor redColor];
    lable.font = [UIFont systemFontOfSize:CZSelectedFontSize];
    lable.textAlignment = NSTextAlignmentCenter;
    [lable sizeToFit];
    lable.font = [UIFont systemFontOfSize:CZNormalFontSize];
//    允许交互
    [lable setUserInteractionEnabled:YES];
    return lable;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(MyLableDidSelect:)]) {
        [self.delegate MyLableDidSelect:self];
    }

}
@end
