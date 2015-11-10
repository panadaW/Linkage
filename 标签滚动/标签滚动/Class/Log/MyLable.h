//
//  MyLable.h
//  标签滚动
//
//  Created by 王明申 on 15/11/10.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyLableDelegate;
@interface MyLable : UILabel
@property(nonatomic,assign)float scale;
@property(nonatomic,weak)id<MyLableDelegate>delegate;
//设置标签
+(MyLable*)setUpLable:(NSString *)title;
@end

@protocol MyLableDelegate <NSObject>

-(void)MyLableDidSelect:(UILabel*)lable;

@end