//
//  MyLable.h
//  标签滚动
//
//  Created by 王明申 on 15/11/10.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLable : UILabel
@property(nonatomic,assign)float scale;
//设置标签
+(MyLable*)setUpLable:(NSString *)title;
@end
